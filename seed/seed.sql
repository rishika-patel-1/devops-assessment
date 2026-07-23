INSERT INTO hotel_bookings (
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)
SELECT
    (
        ARRAY[
            '11111111-1111-1111-1111-111111111111'::UUID,
            '22222222-2222-2222-2222-222222222222'::UUID,
            '33333333-3333-3333-3333-333333333333'::UUID,
            '44444444-4444-4444-4444-444444444444'::UUID,
            '55555555-5555-5555-5555-555555555555'::UUID
        ]
    )[1 + ((n - 1) % 5)],

    'HOTEL-' || LPAD(((n - 1) % 20 + 1)::TEXT, 3, '0'),

    (
        ARRAY[
            'delhi',
            'mumbai',
            'pune',
            'indore',
            'bengaluru',
            'hyderabad'
        ]
    )[1 + ((n - 1) % 6)],

    CURRENT_DATE + ((n % 20) + 1),
    CURRENT_DATE + ((n % 20) + 3),

    ROUND((1500 + RANDOM() * 18500)::NUMERIC, 2),

    (
        ARRAY[
            'pending',
            'confirmed',
            'cancelled',
            'completed'
        ]
    )[1 + ((n - 1) % 4)],

    CURRENT_TIMESTAMP - ((n % 60) || ' days')::INTERVAL

FROM generate_series(1, 120) AS n;


INSERT INTO booking_events (
    booking_id,
    event_type,
    payload,
    created_at
)
SELECT
    id,
    'booking_created',
    jsonb_build_object(
        'source', 'seed',
        'status', status
    ),
    created_at
FROM hotel_bookings
ORDER BY created_at DESC
LIMIT 60;


INSERT INTO booking_events (
    booking_id,
    event_type,
    payload,
    created_at
)
SELECT
    id,
    CASE
        WHEN status = 'confirmed' THEN 'booking_confirmed'
        WHEN status = 'cancelled' THEN 'booking_cancelled'
        WHEN status = 'completed' THEN 'checkout_completed'
        ELSE 'payment_pending'
    END,
    jsonb_build_object(
        'amount', amount,
        'city', city
    ),
    created_at + INTERVAL '1 hour'
FROM hotel_bookings
ORDER BY created_at DESC
LIMIT 40;