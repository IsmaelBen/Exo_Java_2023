<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
  private String esc(String s){
    if(s==null) return "";
    return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;");
  }
%>
<html>
<head>
<title>Les chaines</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les chaines de charactères</h1>
<form action="#" method="post">
    <p>Saisir une chaine (Du texte avec 6 caractères minimum) : <input type="text" id="inputValeur" name="chaine">
    <p><input type="submit" value="Afficher">
</form>
<% String chaine = request.getParameter("chaine"); %>

<% if (chaine != null) { %>
<% if (chaine.length() < 6) { %>
  <p style="color:red;">Veuillez saisir au moins 6 caractères.</p>
<% } else { %>

<% int longueurChaine = chaine.length(); %>
<p>La longueur de votre chaîne est de <%= longueurChaine %> caractères</p>

<% char caractereExtrait = chaine.charAt(2); %>
<p>Le 3° caractère de votre chaine est la lettre <%= esc(String.valueOf(caractereExtrait)) %></p>

<% String sousChaine = chaine.substring(2, 6); %>
<p>Une sous chaine de votre texte : <%= esc(sousChaine) %></p>

<% char recherche = 'e';
   int position = chaine.indexOf(recherche); %>
<p>Votre premier "e" est en : <%= position %></p>

<h2>Exercice 1 : Combien de 'e' dans notre chaine de charactère ?</h2>
<%
  int nbE = 0;
  for (int i = 0; i < chaine.length(); i++) {
    if (chaine.charAt(i) == 'e') nbE++;
  }
%>
<p>Nombre de 'e' : <%= nbE %></p>

<h2>Exercice 2 : Affichage verticale</h2>
<p>
<%
  for (int i = 0; i < chaine.length(); i++) {
    out.print(esc(String.valueOf(chaine.charAt(i))) + "<br/>");
  }
%>
</p>

<h2>Exercice 3 : Retour à la ligne</h2>
<p>
<%
  String mot = "";
  for (int i = 0; i < chaine.length(); i++) {
    char c = chaine.charAt(i);
    if (c == ' ') {
      if (!mot.isEmpty()) { out.print(esc(mot) + "<br/>"); mot = ""; }
    } else {
      mot += c;
    }
  }
  if (!mot.isEmpty()) out.print(esc(mot) + "<br/>");
%>
</p>

<h2>Exercice 4 : Afficher une lettre sur deux</h2>
<p>
<%
  String uneSurDeux = "";
  for (int i = 0; i < chaine.length(); i += 2) {
    uneSurDeux += chaine.charAt(i);
  }
  out.print(esc(uneSurDeux));
%>
</p>

<h2>Exercice 5 : La phrase en verlant</h2>
<p>
<%
  String reverse = "";
  for (int i = chaine.length() - 1; i >= 0; i--) {
    char c = chaine.charAt(i);
    if (c == '’') c = '\'';
    reverse += c;
  }
  out.print(esc(reverse));
%>
</p>

<h2>Exercice 6 : Consonnes et voyelles</h2>
<%
  String norm = chaine
    .toLowerCase()
    .replace('à','a').replace('â','a').replace('ä','a')
    .replace('é','e').replace('è','e').replace('ê','e').replace('ë','e')
    .replace('î','i').replace('ï','i')
    .replace('ô','o').replace('ö','o')
    .replace('ù','u').replace('û','u').replace('ü','u')
    .replace('ÿ','y');
  int voyelles = 0, consonnes = 0;
  for (int i = 0; i < norm.length(); i++) {
    char c = norm.charAt(i);
    if (c >= 'a' && c <= 'z') {
      if (c=='a'||c=='e'||c=='i'||c=='o'||c=='u'||c=='y') voyelles++;
      else consonnes++;
    }
  }
%>
<p>Voyelles : <%= voyelles %> — Consonnes : <%= consonnes %></p>

<% } } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
