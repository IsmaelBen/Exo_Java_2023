<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les tableaux</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les tableaux</h1>

<form action="#" method="post">
  <p>Saisir au minimum 3 chiffres à la suite, exemple : 6 78 15
     <input type="text" id="inputValeur" name="chaine">
  <p><input type="submit" value="Afficher">
</form>

<%
  String chaine = request.getParameter("chaine");
  if (chaine != null) {
    String[] tokens = chaine.trim().split("\\s+");
    java.util.List<Integer> valeurs = new java.util.ArrayList<Integer>();

    for (String t : tokens) {
      if (t.matches("-?\\d+")) { // on ne garde que les entiers valides
        try { valeurs.add(Integer.parseInt(t)); } catch (NumberFormatException ignore) {}
      }
    }
%>

<% if (valeurs.isEmpty()) { %>
  <p style="color:red;">Veuillez saisir au moins des entiers séparés par des espaces (ex: 6 78 15).</p>
<% } else { %>

  <h3>Valeurs reconnues</h3>
  <p>Le tableau contient <%= valeurs.size() %> valeur(s) :</br>
  <%
    for (int i = 0; i < valeurs.size(); i++) {
      out.print("[" + i + "] = " + valeurs.get(i) + (i < valeurs.size()-1 ? ", " : ""));
    }
  %>
  </p>

  <h2>Exercice 1 : Le carré de la première valeur</h2>
  <%
    if (valeurs.size() >= 1) {
      long carre = 1L * valeurs.get(0) * valeurs.get(0); // long pour éviter débordement visuel
  %>
    <p>Carré de la première valeur (<%= valeurs.get(0) %>) : <%= carre %></p>
  <% } else { %>
    <p style="color:#a00;">Impossible : aucune valeur saisie.</p>
  <% } %>

  <h2>Exercice 2 : La somme des 2 premières valeurs</h2>
  <%
    if (valeurs.size() >= 2) {
      long somme2 = 1L * valeurs.get(0) + valeurs.get(1);
  %>
    <p>Somme des deux premières valeurs (<%= valeurs.get(0) %> + <%= valeurs.get(1) %>) : <%= somme2 %></p>
  <% } else { %>
    <p style="color:#a00;">Impossible : il faut au moins 2 valeurs.</p>
  <% } %>

  <h2>Exercice 3 : La somme de toutes les valeurs</h2>
  <%
    long sommeAll = 0L;
    for (int v : valeurs) sommeAll += v;
  %>
  <p>Somme totale : <%= sommeAll %></p>

  <h2>Exercice 4 : La valeur maximale</h2>
  <%
    int max = valeurs.get(0);
    for (int i = 1; i < valeurs.size(); i++) if (valeurs.get(i) > max) max = valeurs.get(i);
  %>
  <p>Maximum : <%= max %></p>

  <h2>Exercice 5 : La valeur minimale</h2>
  <%
    int min = valeurs.get(0);
    for (int i = 1; i < valeurs.size(); i++) if (valeurs.get(i) < min) min = valeurs.get(i);
  %>
  <p>Minimum : <%= min %></p>

  <h2>Exercice 6 : La valeur la plus proche de 0</h2>
  <%
    int proche0_v1 = valeurs.get(0);
    for (int i = 1; i < valeurs.size(); i++) {
      int v = valeurs.get(i);
      if (Math.abs(v) < Math.abs(proche0_v1)) {
        proche0_v1 = v;
      }
      // En cas d'égalité, on NE change PAS (version 1 : pas de préférence)
    }
  %>
  <p>Plus proche de 0 (v1, sans préférence en cas d'égalité) : <%= proche0_v1 %></p>

  <h2>Exercice 7 : La valeur la plus proche de 0 (préférence au positif)</h2>
  <%
    int proche0_v2 = valeurs.get(0);
    for (int i = 1; i < valeurs.size(); i++) {
      int v = valeurs.get(i);
      int av = Math.abs(v), abest = Math.abs(proche0_v2);
      if (av < abest || (av == abest && v > proche0_v2)) {
        // tie-break : si |v| == |best|, choisir le positif
        proche0_v2 = v;
      }
    }
  %>
  <p>Plus proche de 0 (v2, en cas d'égalité on choisit le positif) : <%= proche0_v2 %></p>

<% } // fin else valeurs non vides %>
<% } // fin if(chaine!=null) %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
