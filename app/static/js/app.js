const healthStatus = document.getElementById("health-status");
const bookingTableBody = document.getElementById("booking-table-body");
const cityFilter = document.getElementById("city-filter");
const statusFilter = document.getElementById("status-filter");
const refreshButton = document.getElementById("refresh-button");
const reportButton = document.getElementById("report-button");
const reportOutput = document.getElementById("report-output");

async function loadHealth() {
  try {
    const response = await fetch("/api/health");
    const data = await response.json();

    healthStatus.textContent = `${data.status} · ${data.database}`;
    healthStatus.classList.add("healthy");
  } catch (error) {
    healthStatus.textContent = "unhealthy";
    healthStatus.classList.add("unhealthy");
  }
}

async function loadDashboard() {
  const response = await fetch("/api/dashboard");
  const data = await response.json();

  document.getElementById("total-bookings").textContent =
    data.total_bookings;

  document.getElementById("total-amount").textContent =
    `₹${Number(data.total_amount).toLocaleString("en-IN")}`;

  document.getElementById("confirmed-bookings").textContent =
    data.confirmed_bookings;

  document.getElementById("pending-bookings").textContent =
    data.pending_bookings;
}

async function loadBookings() {
  const params = new URLSearchParams();

  if (cityFilter.value) {
    params.append("city", cityFilter.value);
  }

  if (statusFilter.value) {
    params.append("status", statusFilter.value);
  }

  const response = await fetch(`/api/bookings?${params.toString()}`);
  const bookings = await response.json();

  bookingTableBody.innerHTML = "";

  bookings.forEach((booking) => {
    const row = document.createElement("tr");

    row.innerHTML = `
      <td>${booking.hotel_id}</td>
      <td>${booking.city}</td>
      <td>
        <span class="badge ${booking.status}">
          ${booking.status}
        </span>
      </td>
      <td>₹${Number(booking.amount).toLocaleString("en-IN")}</td>
      <td>${booking.checkin_date}</td>
      <td>${new Date(booking.created_at).toLocaleString()}</td>
    `;

    bookingTableBody.appendChild(row);
  });
}

async function loadReport() {
  reportOutput.textContent = "Loading...";

  const response = await fetch(
    "/api/reports/delhi-last-30-days"
  );

  const data = await response.json();

  reportOutput.textContent = JSON.stringify(data, null, 2);
}

refreshButton.addEventListener("click", loadBookings);
cityFilter.addEventListener("change", loadBookings);
statusFilter.addEventListener("change", loadBookings);
reportButton.addEventListener("click", loadReport);

Promise.all([
  loadHealth(),
  loadDashboard(),
  loadBookings()
]);