
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
        import="java.util.*, java.time.*, java.time.format.*"%>

<%! 
  // ---- Modèle "Task" en POO (attributs privés) ----
  public static class Task implements java.io.Serializable {
    private final int id;
    private String title;
    private String description;
    private LocalDate dueDate;
    private boolean done;

    public Task(int id, String title, String description, LocalDate dueDate) {
      this.id = id;
      this.title = title;
      this.description = description;
      this.dueDate = dueDate;
      this.done = false;
    }
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public LocalDate getDueDate() { return dueDate; }
    public boolean isDone() { return done; }
    public void setDone(boolean d) { this.done = d; }
  }

  // ---- Helpers d'affichage ----
  private String esc(String s){
    if(s==null) return "";
    return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
  }
  private String fmt(LocalDate d){
    if(d==null) return "";
    return d.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
  }
%>

<%
  request.setCharacterEncoding("UTF-8");

  // --- Session state (liste + compteur d'ID) ---
  @SuppressWarnings("unchecked")
  List<Task> tasks = (List<Task>) session.getAttribute("tasks");
  if (tasks == null) {
    tasks = new ArrayList<>();
    session.setAttribute("tasks", tasks);
    session.setAttribute("nextId", Integer.valueOf(1));
  }
  int nextId = ((Integer) session.getAttribute("nextId")).intValue();

  String self = request.getRequestURI();
  String method = request.getMethod();
  String action = request.getParameter("action");
  String view   = request.getParameter("view");
  if (view == null) view = "home";

  // --- Actions ---
  if ("add".equals(action) && "POST".equalsIgnoreCase(method)) {
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String dueStr = request.getParameter("due");
    LocalDate due = null;
    if (dueStr != null && !dueStr.isEmpty()) {
      try { due = LocalDate.parse(dueStr); } catch(Exception ignore){}
    }
    if (title != null && !title.trim().isEmpty()) {
      Task t = new Task(nextId, title.trim(), description==null?"":description.trim(), due);
      tasks.add(t);
      nextId++;
      session.setAttribute("nextId", Integer.valueOf(nextId));
    }
    response.sendRedirect(self + "?view=list");
    return;
  }

  if ("delete".equals(action)) {
    String idStr = request.getParameter("id");
    if (idStr != null) {
      try {
        int id = Integer.parseInt(idStr);
        Iterator<Task> it = tasks.iterator();
        while (it.hasNext()) {
          if (it.next().getId() == id) { it.remove(); break; }
        }
      } catch(Exception ignore){}
    }
    response.sendRedirect(self + "?view=list");
    return;
  }

  if ("toggle".equals(action)) {
    String idStr = request.getParameter("id");
    if (idStr != null) {
      try {
        int id = Integer.parseInt(idStr);
        for (Task t : tasks) {
          if (t.getId() == id) { t.setDone(!t.isDone()); break; }
        }
      } catch(Exception ignore){}
    }
    response.sendRedirect(self + "?view=list");
    return;
  }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"/>
  <title>Mini Gestionnaire de Tâches</title>
  <style>
    body { font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; margin: 24px; background:#f9fafb; }
    header { display:flex; gap:12px; align-items:center; margin-bottom:18px; }
    .nav a { text-decoration:none; padding:8px 12px; border-radius:10px; background:#fff; border:1px solid #e5e7eb; }
    .nav a.active { background:#111827; color:#fff; border-color:#111827; }
    h1 { margin:0 0 8px 0; font-size:22px; }
    .card { background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:16px; margin-bottom:16px; }
    table { width:100%; border-collapse:collapse; background:#fff; border:1px solid #e5e7eb; border-radius:12px; overflow:hidden; }
    th, td { padding:10px 12px; border-bottom:1px solid #f1f5f9; text-align:left; }
    th { background:#f8fafc; font-weight:600; }
    tr:last-child td { border-bottom:none; }
    .muted { color:#6b7280; }
    .done { text-decoration: line-through; color:#6b7280; }
    .actions a, .actions button {
      padding:6px 10px; border-radius:8px; border:1px solid #e5e7eb; background:#fff; text-decoration:none; cursor:pointer;
    }
    .actions a.danger, .actions button.danger { border-color:#ef4444; color:#b91c1c; }
    form.inline { display:inline; margin:0; }
    input[type=text], textarea, input[type=date] {
      width:100%; padding:10px; border:1px solid #e5e7eb; border-radius:10px; background:#fff;
    }
    label { display:block; margin:8px 0 6px; font-weight:600; }
    .grid { display:grid; grid-template-columns:1fr 1fr; gap:12px; }
    .btn { padding:10px 14px; border-radius:10px; border:1px solid #111827; background:#111827; color:#fff; cursor:pointer; }
  </style>
</head>
<body>
<header>
  <h1>Mini Gestionnaire de Tâches</h1>
  <nav class="nav">
    <a href="<%= self %>?view=home"  class="<%= "home".equals(view) ? "active":"" %>">Accueil</a>
    <a href="<%= self %>?view=add"   class="<%= "add".equals(view)  ? "active":"" %>">Ajouter une tâche</a>
    <a href="<%= self %>?view=list"  class="<%= "list".equals(view) ? "active":"" %>">Afficher les tâches (<%= tasks.size() %>)</a>
  </nav>
</header>

<% if ("home".equals(view)) { %>
  <div class="card">
    <h3>Objectif</h3>
    <p>Application JSP/Servlets minimaliste (tout-en-un JSP) permettant&nbsp;:</p>
    <ul>
      <li>d’ajouter des tâches (titre, description, date d’échéance),</li>
      <li>de lister les tâches de la session utilisateur,</li>
      <li>de marquer une tâche comme terminée,</li>
      <li>de supprimer une tâche.</li>
    </ul>
    <p class="muted">Les données sont stockées en session (pas de base de données).</p>
  </div>
<% } %>

<% if ("add".equals(view)) { %>
  <div class="card">
    <h3>Ajouter une tâche</h3>
    <form action="<%= self %>?action=add" method="post">
      <label for="title">Titre *</label>
      <input type="text" id="title" name="title" required maxlength="120"/>

      <label for="description">Description</label>
      <textarea id="description" name="description" rows="4" maxlength="1000"></textarea>

      <div class="grid">
        <div>
          <label for="due">Date d’échéance</label>
          <input type="date" id="due" name="due"/>
        </div>
        <div style="display:flex; align-items:flex-end; justify-content:flex-end;">
          <button type="submit" class="btn">Enregistrer</button>
        </div>
      </div>
    </form>
  </div>
<% } %>

<% if ("list".equals(view)) { %>
  <div class="card">
    <h3>Mes tâches (<%= tasks.size() %>)</h3>
    <% if (tasks.isEmpty()) { %>
      <p class="muted">Aucune tâche pour l’instant. <a href="<%= self %>?view=add">Ajouter une tâche</a>.</p>
    <% } else { %>
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Titre</th>
            <th>Description</th>
            <th>Échéance</th>
            <th>Statut</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
        <%
          // Optionnel : trier par statut (non terminées d'abord), puis par date
          tasks.sort(new Comparator<Task>() {
            public int compare(Task a, Task b) {
              if (a.isDone() != b.isDone()) return a.isDone() ? 1 : -1;
              LocalDate da = a.getDueDate(), db = b.getDueDate();
              if (da == null && db == null) return 0;
              if (da == null) return 1;
              if (db == null) return -1;
              return da.compareTo(db);
            }
          });

          for (Task t : tasks) {
            String rowClass = t.isDone() ? "done" : "";
        %>
          <tr>
            <td><%= t.getId() %></td>
            <td class="<%= rowClass %>"><%= esc(t.getTitle()) %></td>
            <td class="<%= rowClass %>"><%= esc(t.getDescription()) %></td>
            <td class="<%= rowClass %>"><%= fmt(t.getDueDate()) %></td>
            <td><%= t.isDone() ? "Terminée" : "En cours" %></td>
            <td class="actions">
              <a href="<%= self %>?action=toggle&id=<%= t.getId() %>"><%= t.isDone() ? "Marquer en cours" : "Marquer terminée" %></a>
              <a class="danger" href="<%= self %>?action=delete&id=<%= t.getId() %>" 
                 onclick="return confirm('Supprimer la tâche #<%= t.getId() %> ?');">Supprimer</a>
            </td>
          </tr>
        <% } %>
        </tbody>
      </table>
    <% } %>
  </div>
<% } %>

</body>
</html>
