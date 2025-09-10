<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Boucles</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les boucles</h1>
<form action="#" method="post">
    <label for="inputValeur">Saisir le nombre d'étoiles : </label>
    <input type="text" id="inputValeur" name="valeur">
    <input type="submit" value="Afficher">
</form>

<%-- Récupération de la valeur saisie par l'utilisateur --%>
<% String valeur = request.getParameter("valeur"); %>
    
<%-- Vérification de l'existence de la valeur --%>
<% if (valeur != null && !valeur.isEmpty()) { %>

<%-- Boucle for pour afficher une ligne d'étoiles --%>
    <%int cpt = Integer.parseInt(valeur); %>
    <p>
    <% for (int i = 1; i <= cpt; i++) { %>
       <%= "*" %>
    <% } %>
    </p>

<h2>Exercice 1 : Le carré d'étoiles</h2>
<p>Ecrire le code afin de produire un carré d'étoile</p>
<%-- Boucle for pour afficher un carré d'étoile --%>
    <p>
    <% for (int i = 1; i <= cpt; i++) { %>
        <% for (int j = 1; j <= cpt; j++) { %>
           <%= "*" %>
        <% } %>
    </br>
    <% } %>
    </p>

<h2>Exercice 2 : Triangle rectangle gauche</h2>
<p>Ecrire le code afin de produire un triangle rectangle aligné sur la gauche</p>
<%-- Boucle for pour afficher un triangle rectangle aligné sur la gauche --%>
    <p>
    <% for (int i = 1; i <= cpt; i++) { %>
        <% for (int j = 1; j <= i; j++) { %>
           <%= "*" %>
        <% } %>
    </br>
    <% } %>
    </p>

<h2>Exercice 3 : Triangle rectangle inversé</h2>
<p>Ecrire le code afin de produire un triangle rectangle aligné sur la gauche</p>
<%-- Boucle for pour afficher un triangle rectangle aligné sur la gauche --%>
    <p>
    <% for (int i = cpt; i >= 1; i--) { %>
        <% for (int j = i; j >= 1; j--) { %>
           <%= "*" %>
        <% } %>
    </br>
    <% } %>
    </p>

<h2>Exercice 4 : Triangle rectangle 2</h2>
<p>Ecrire le code afin de produire un triangle rectangle aligné sur la droite</p>
<%-- Boucle for pour afficher un triangle rectangle aligné sur la droite --%>
    <p>
    <% for (int i = cpt; i >= 1; i--) { %>
        <%-- Affichage des espaces --%>
        <% for (int l = cpt - i; l >= 1; l--) { %>
            &nbsp;&nbsp;
        <% } %>

        <%-- Affichage des étoiles --%>
        <% for (int j = 1; j <= i; j++) { %>
           <%= "*" %>
        <% } %>
    </br>
    <% } %>
    </p>

<h2>Exercice 5 : Triangle isocele</h2>
<p>Ecrire le code afin de produire un triangle isocele</p>
<%-- Boucle for pour afficher un triangle rectangle aligné sur la droite --%>
    <p>
    <% for (int i = cpt; i >= 1; i--) { %>
        <%-- Affichage des espaces --%>
        <% for (int l = cpt - i; l >= 1; l--) { %>
            &nbsp;
        <% } %>

        <%-- Affichage des étoiles --%>
        <% for (int j = 1; j <= i; j++) { %>
           <%= "*" %>
        <% } %>
    </br>
    <% } %>
    </p>

<h2>Exercice 6 : Le demi losange</h2>
<p>Ecrire le code afin de produire un losange</p>
<%-- Boucle for pour afficher un triangle rectangle croissant --%>
    <p>
    <% for (int i = 1; i <= cpt; i++) { %>
        <%-- Affichage des espaces --%>
        <% for (int l = 1; l <= cpt - i; l++) { %>
            &nbsp;&nbsp;
        <% } %>

        <%-- Affichage des étoiles --%>
        <% for (int j = 1; j <= i; j++) { %>
           <%= "*" %>
        <% } %>
    </br>
    <% } %>
    </p>

<%-- Boucle for pour afficher un triangle rectangle décroissant --%>
    <p>
    <% for (int i = cpt; i >= 1; i--) { %>
        <%-- Affichage des espaces --%>
        <% for (int l = cpt - i; l >= 1; l--) { %>
            &nbsp;&nbsp;
        <% } %>

        <%-- Affichage des étoiles --%>
        <% for (int j = 1; j <= i; j++) { %>
           <%= "*" %>
        <% } %>
    </br>
    <% } %>
    </p>

<h2>Exercice 7 : La table de multiplication</h2>
<p>Ecrire le code afin de créser une table de multiplication</p>
<%-- Boucle for pour afficher une table de multiplication --%>
    <p>
    <% for (int i = 1; i <= cpt; i++) { %>
        <%= cpt %> x <%= i %> = <%= (cpt * i) %> <br/>
    <% } %>
    </p>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
