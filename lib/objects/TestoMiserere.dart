import 'dart:convert';

class TestoMiserere {
  final String titolo;
  final List<StrofaTestoMiserere> strofe;

  TestoMiserere({
    required this.titolo,
    required this.strofe,
  });

  factory TestoMiserere.fromJson(Map<String, dynamic> json) {
    return TestoMiserere(titolo: json['titolo'], strofe: json['strofe']);
  }

  static getTesto() {
    List<StrofaTestoMiserere> listaStrofe = List.empty(growable: true);
    Map<String, dynamic> testoJson = jsonDecode(
        "{ \"titolo\": \"MISERERE (Salmo 50)\",\"strofe\": [{ \"cantato\": \"Miserere mei, Deus, secundum magnam misericordiam tuam.\", \"letto\": \"Et secundum multitudinem miserationum tuarum, dele iniquitatem meam.\"},{ \"cantato\": \"Amplius lava me ab iniquitate mea: et a peccato meo munda me.\", \"letto\": \"Quoniam iniquitatem meam ego cognosco: et peccatum meum contra me est semper.\"},{ \"cantato\": \"Tibi soli peccavi et malum coram te feci: ut justificeris in sermonibus tuis, et vincas cum judicaris.\", \"letto\": \"Ecce enim in iniquitatibus conceptus sum: et in peccatis concepit me mater mea.\"},{ \"cantato\": \"Ecce enim veritatem dilexisti: incerta et occulta sapientiae tuae manifestasti mihi.\", \"letto\": \"Asperges me hyssopo, et mundabor: lavabis me, et super nivem dealbabor.\"},{ \"cantato\": \"Auditui meo dabis gaudium et laetitiam: et exultabunt ossa humiliata.\", \"letto\": \"Averte faciem tuam a peccatis meis: et omnes iniquitates meas dele.\"},{ \"cantato\": \"Cor mundum crea in me, Deus: et spiritum rectum innova in visceribus meis.\", \"letto\": \"Ne projicias me a facie tua: et Spiritum sanctum tuum ne auferas a me.\"},{ \"cantato\": \"Redde mihi laetitiam salutaris tui: et spiritu principali confirma me.\", \"letto\": \"Docebo iniquos vias tuas: et impii ad te convertentur.\"},{ \"cantato\": \"Libera me de sanguinibus, Deus, Deus salutis meae: et exultabit lingua mea justitiam tuam.\", \"letto\": \"Domine, labia mea aperies: et os meum annuntiabit laudem tuam.\"},{ \"cantato\": \"Quoniam si voluisses sacrificium, dedissem utique: holocaustis non delectaberis.\", \"letto\": \"Sacraficium Deo spiritus contribulatus: cor contritum et humiliatum Deus non despicies.\"},{ \"cantato\": \"Benigne fac, Domine, in bona voluntate tua Sion: ut aedificentur muri Jerusalem.\", \"letto\": \"Tunc acceptabis sacrificium justitiae, oblationes, et holocausta: tunc imponent super altare tuum vitulos.\"}]}");
    for (int i = 0; i < testoJson['strofe'].length; i++) {
      StrofaTestoMiserere strofa = StrofaTestoMiserere(
          cantato: testoJson['strofe'][i]['cantato'],
          letto: testoJson['strofe'][i]['letto']);
      listaStrofe.add(strofa);
    }
    TestoMiserere testo =
        TestoMiserere(titolo: testoJson['titolo'], strofe: listaStrofe);
    return testo;
  }
}

class StrofaTestoMiserere {
  final String cantato;
  final String letto;

  StrofaTestoMiserere({
    required this.cantato,
    required this.letto,
  });

  factory StrofaTestoMiserere.fromJson(Map<String, dynamic> json) {
    return StrofaTestoMiserere(cantato: json['cantato'], letto: json['letto']);
  }
}
