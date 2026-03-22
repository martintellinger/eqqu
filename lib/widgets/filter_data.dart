// Filter option constants used by bottom sheet filters.

const categoryLabels = [
  'Koně',
  'Jezdci',
  'Stáj',
  'Psi',
  'Knihy, hračky, dárky',
  'Umění',
  'Veterinární produkty',
  'Krmivo',
  'Terapeutické přístroje',
];

const categorySvgs = [
  'assets/icons/Kone.svg',
  'assets/icons/Jezdci.svg',
  'assets/icons/Staj.svg',
  'assets/icons/Psi.svg',
  'assets/icons/Kniha_hracky_darky.svg',
  'assets/icons/Kone.svg',
  'assets/icons/Veterinarni_produkty.svg',
  'assets/icons/Krmivo.svg',
  'assets/icons/erapeuticke_pristroje.svg',
];

const subcategoriesMap = <String, List<String>>{
  'Koně': ['Sedla', 'Podsedlové dečky', 'Tlumící podsedlovky', 'Podbřišníky', 'Udidla', 'Uzdečky a uzdy', 'Deky', 'Martingaly a poprsníky', 'Kamaše a chrániče', 'Třmeny a třmenové řemeny'],
  'Jezdci': ['Helmy', 'Rajtky', 'Boty', 'Vesty', 'Rukavice', 'Bundy'],
  'Stáj': ['Kbelíky a krmítka', 'Čištění', 'Podestýlky', 'Stájové vybavení'],
  'Psi': ['Obojky', 'Vodítka', 'Pelíšky', 'Hračky', 'Misky'],
  'Knihy, hračky, dárky': ['Knihy', 'Hračky', 'Dárkové sety', 'Puzzle', 'Modely koní'],
  'Umění': ['Obrazy', 'Sochy', 'Fotografie', 'Plakáty'],
  'Veterinární produkty': ['Doplňky stravy', 'Ošetření kopyt', 'Obvazy a náplasti', 'Dezinfekce'],
  'Krmivo': ['Müsli', 'Granule', 'Seno a sláma', 'Pamlsky', 'Minerály'],
  'Terapeutické přístroje': ['Magnetoterapie', 'Lasery', 'Masážní přístroje', 'Solné lampy'],
};

const sortOptions = [
  'Relevance',
  'Od nejlevnějšího',
  'Od nejdražšího',
  'Od nejnovějších',
];

const conditionOptions = [
  'Nové s visačkou',
  'Nové bez visačky',
  'Velmi dobré',
  'Dobré',
  'Uspokojivé',
];

const sizeOptions = [
  'XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL',
  '14"', '15"', '16"', '16.5"', '17"', '17.5"', '18"',
];

const brandOptions = [
  'Kentucky',
  'Eskadron',
  'BR',
  'Horze',
  'HKM',
  'Cavallo',
  'Prestige',
  'Stübben',
  'Passier',
  'Busse',
  'Pikeur',
  'Kingsland',
  'Schockemöhle',
  'Equiline',
  'Animo',
];

const genderOptions = [
  'Muži',
  'Ženy',
  'Unisex',
  'Děti',
];

const colorOptions = [
  'Černá',
  'Bílá',
  'Hnědá',
  'Modrá',
  'Červená',
  'Zelená',
  'Šedá',
  'Béžová',
  'Růžová',
  'Fialová',
];

const materialOptions = [
  'Kůže',
  'Syntetika',
  'Bavlna',
  'Vlna',
  'Polyester',
  'Neopren',
  'Fleece',
];

const favoriteOptions = [
  'Všechny',
  'Jen oblíbené produkty',
];
