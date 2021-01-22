# THPJ14
Scraping with the Nokogiri gem
<h2>1. Introduction</h2>
<p>Aujourd'hui, tu vas automatiser la récupération massive de données issus de sites internet (= tu vas scraper). Tes compétences en Ruby et en HTML vont te permettre de récupérer ces informations en moins d'une journée. Tu t'amuseras avec le cours des cryptomonnaies, tu iras récupérer les e-mails des mairies de notre beau pays, puis tu chopperas la liste des e-mails des députés de France. Tu ne te penses pas capable de tout ça ? Et bien tu vas voir que si.</p>

<p>Les standards habituels seront attendus : un dossier bien rangé, de beaux README et Gemfile, des tests qui vérifient que tout fonctionne.</p>

<h2>2. Le projet</h2>
<h3>2.1. Initialize</h3>
<p>Commence par créer une structure de dossier propre avec le dossier lib, le dossier spec, etc. Créé un Gemfile, un README et fais ton <code>$ git init</code>. Maintenant on peut commencer à travailler 😘</p>


<h3>2.2. Dark Trader</h3>
<p>Lehman Brothers, impressionnés par ton algorithme d'optimisation d'achat / vente, veut encore faire appel à toi. Leur Chief Digital Officer, très hype, a entendu parler au JT de TF1 d'un "<i>truc révolutionnaire qui s'appelle le bloque-chienne</i>". Il veut en acheter plein. Pour le conseiller, tu vas devoir récupérer le cours de toutes les cryptomonnaies du marché.</p>

<p>En prenant pour source le site <a href="https://coinmarketcap.com/all/views/all/" target="_blank">CoinMarketCap</a>, fait un programme qui récupère le cours de toutes les cryptomonnaies et les enregistre bien proprement dans un array de hashs. <br> Ton array devra avoir le format suivant :</p>

<pre><code class="language-ruby">a = [
  { "BTC" => 5245.12 },
  { "ETH" => 217.34 }, 
  etc
]</code></pre>


<p>Pour les tests, inspire-toi de la ressource plus haut. Il n'y a pas besoin de faire 36 000 tests, il faut juste arriver à tester 1) le fonctionnement de base de ton programme (pas d'erreur ni de retour vide) et 2) que ton programme sort bien un array cohérent (vérifier la présence de 2-3 cryptomonnaies, vérifier que l’array est de taille cohérente, etc.).</p>

<p>Quelques petites aides pour ce premier exercice :</p>
<ul>
  <li>Il est possible de faire le programme en n'allant que sur une seule URL. C'est un bon moyen pour faire un programme rapide car ne chargeant pas 2000 pages HTML.</li>
  <li>Tout se jouera sur la rédaction d'un XPath pertinent et précis qui extrait juste ce qu'il faut d'éléments HTML. Puis un bon traitement de ces éléments pour en extraire les 2 infos dont tu as besoin : le nom des crypto et leur cours.</li>
  <li>Un programme qui scrappe sans rien te dire, c'est non seulement nul mais en plus, tu ne sais pas s'il marche, s'il tourne en boucle ou s’il attend que ton wifi fonctionne. <b>Mets des <code>puts</code> dans ton code pour que ton terminal affiche quelque chose à chaque fois qu'il a pu récupérer une donnée</b>. Comme ça tu vois ton scrappeur qui fonctionne et avec des mots qui apparaissent tout seul sur ton terminal, tu vas donner l'impression que t'es un hacker. Stylaï.</li>
  <li><b>Pense à bien nommer tes variables pour ne pas te perdre !</b> Par exemple, quand tu as un array, nomme-le <code>crypto_name_array</code> ou à minima mets son nom au pluriel <code>crypto_nameS</code>. Sinon tu vas oublier que c'est un array et tu vas tenter des <code>.text</code> dessus alors qu'il faut bosser avec un <code>.each</code>.</li>
  <li>Rappel: un hash s’initialise avec <code>result = Hash.new</code> et on y stocke des infos avec <code>result['ta_key'] = 'ta_value'</code> </li>
  <li>N'hésite pas à <b>découper ton programme en plusieurs étapes simples et dont le fonctionnement est facile à vérifier</b>. Par exemple : 1) Isoler les éléments HTML qui vont bien, 2) En extraire le texte et mettre ça dans un hash, 3) Réorganiser ce hash dans un array de plusieurs mini-hash comme demandé. <br>Même si ça n'est pas le chemin le plus court, l'essentiel est que chaque petite étape te fasse avancer et qu'à chaque fois tu te dises "ok, étape 1), ça fonctionne nickel - pas de bug. Passons à la suite".</li>
</ul>

<h3>2.3. Mairie christmas</h3>

<p>Le CEO de Get-email Corp a besoin de tes services. Il voudrait toutes les adresses e-mail des mairies du Val d'Oise. Aucun souci pour toi. Va sur <a href="http://annuaire-des-mairies.com/" target="_blank">cet annuaire des mairies</a> et récupère les adresses e-mails des mairies du Val d'Oise. Comme pour l'exercice précédent, tu devras enregistrer les données dans un array de hash suivant ce format :</p>

<pre><code class="language-ruby">a = [
  { "ville_1" => "email_1" },
  { "ville_2" => "email_2" }, 
  etc
]</code></pre>


<p>Décomposons le programme en 2 sous-problème simples:</p>
<ol>
  <li>Tu dois être capable d'obtenir un e-mail de mairie à partir de la page de cette dernière (pas en partant du listing complet des mairies). Fais d'abord une méthode <code>get_townhall_email(townhall_url)</code> qui récupère l’e-mail d'une mairie à partir de l'URL de mairies, par exemple celle de <a href="https://www.annuaire-des-mairies.com/95/avernes.html" target="_blank">Avernes</a>.</li>
  <li>Une fois que tu sais le faire pour une mairie, tu vas vouloir industrialiser et répéter ça sur tout l'annuaire du Val d'Oise. La prochaine étape est de coder une méthode <code>get_townhall_urls</code> qui récupère les URLs de <a href="https://www.annuaire-des-mairies.com/val-d-oise.html">chaque ville du Val d'Oise</a>.</li>
</ol>

<p>Quand tu es assez sûr que chaque méthode marche séparément, tu as juste à imbriquer les deux et à toi la gloire.</p>

<p>Pour les tests, ce sera la même chose que pour l'exercice précédent mais appliqué aux deux méthodes : des tests de fonctionnement de base et des tests de cohérence du résultat.</p>

<h3>2.4. Cher député </h3>
<p>Maintenant, fini de se faire mâcher le travail par tes gentils formateurs de THP. Tu dois récupérer la liste complète des députés de France ainsi que leurs adresses e-mail. Cherche par toi-même le site le plus aisé à scrapper et stocke les informations extraites dans une array de hashs selon ce format (un peu différent des exercices précédents) : </p>

<pre><code class="language-ruby">a = [
  { 
    "first_name" => "Jean",
    "last_name" => "Durant",
    "email" => "jean.durant@assemblée.fr"
  },
  { 
    "first_name" => "Martin",
    "last_name" => "Dupont",
    "email" => "martin.dupont@assemblée.fr"
  },
  etc
]</code></pre>

<p>Pour les tests, nous t'invitons à te poser et t'inspirer des tests précédents. Deux tests suffiront.</p>

<h2>3. Rendu attendu</h2>
<p>Un repo GitHub propre qui contient un fichier de scrapping pour chacun des trois exercices (dans le dossier lib), des tests pour chacun des scrappeurs (dossier spec), un Gemfile et un README qui explique le tout. Pas de surprise.</p>

