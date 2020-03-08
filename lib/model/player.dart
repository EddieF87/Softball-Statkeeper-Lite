import 'package:meta/meta.dart';
import 'package:sleekstats_flutter_statkeeper/database/db_contract.dart';

class Player {
  //Display labels for name/team/etc.
  static const String LABEL_NAME = "Name";
  static const String LABEL_TEAM = "Team";

  //Display labels for stats that are changeable.
  static const String LABEL_G = "G";
  static const String LABEL_1B = "1B";
  static const String LABEL_2B = "2B";
  static const String LABEL_3B = "3B";
  static const String LABEL_HR = "HR";
  static const String LABEL_BB = "BB";
  static const String LABEL_HBP = "HBP";
  static const String LABEL_ROE = "RoE";
  static const String LABEL_OUT = "OUT";
  static const String LABEL_K = "K";
  static const String LABEL_SF = "SF";
  static const String LABEL_SB = "SB";
  static const String LABEL_R = "R";
  static const String LABEL_RBI = "RBI";

  static const Set<String> CHANGEABLE_LABELS = {
    LABEL_G,
    LABEL_1B,
    LABEL_2B,
    LABEL_3B,
    LABEL_HR,
    LABEL_BB,
    LABEL_HBP,
    LABEL_ROE,
    LABEL_OUT,
    LABEL_K,
    LABEL_SF,
    LABEL_SB,
    LABEL_R,
    LABEL_RBI,
  };

  //Display labels for stats that are calculated from others.
  static const String LABEL_H = "H";
  static const String LABEL_AB = "AB";
  static const String LABEL_PA = "PA";
  static const String LABEL_AVG = "AVG";
  static const String LABEL_OBP = "OBP";
  static const String LABEL_SLG = "SLG";
  static const String LABEL_OPS = "OPS";
  static const String LABEL_OBPROE = "OBP+RoE";

  int id;
  String fireID;
  String teamFireID;
  String statkeeperFireID;
  String name;
  String team;
  int games;
  int rbi;
  int runs;
  int singles;
  int doubles;
  int triples;
  int hrs;
  int outs;
  int walks;
  int sacFlies;
  int stolenBases;
  int strikeOuts;
  int hbp;
  int gender;
  int reachedOnErrors;
  int battingOrder;

  Player({
    this.id,
    @required this.fireID,
    this.teamFireID,
    this.statkeeperFireID,
    @required this.name,
    this.team = "Free Agent",
    this.games = 0,
    this.rbi = 0,
    this.runs = 0,
    this.singles = 0,
    this.doubles = 0,
    this.triples = 0,
    this.hrs = 0,
    this.outs = 0,
    this.walks = 0,
    this.sacFlies = 0,
    this.stolenBases = 0,
    this.strikeOuts = 0,
    this.hbp = 0,
    this.gender = 0,
    this.reachedOnErrors = 0,
    this.battingOrder = 99
  })  : assert(fireID != null),
        assert(name != null);

  Map<String, dynamic> toJson() => {
    DBContract.ID: this.id,
    DBContract.FIRESTORE_ID: this.fireID,
    DBContract.TEAM_FIRESTORE_ID: this.teamFireID,
    DBContract.STATKEEPER_FIRESTORE_ID: this.statkeeperFireID,
    DBContract.NAME: this.name,
    DBContract.TEAM: this.team,
    DBContract.GAMES: this.games,
    DBContract.RBI: this.rbi,
    DBContract.RUNS: this.runs,
    DBContract.SINGLES: this.singles,
    DBContract.DOUBLES: this.doubles,
    DBContract.TRIPLES: this.triples,
    DBContract.HRS: this.hrs,
    DBContract.OUTS: this.outs,
    DBContract.WALKS: this.walks,
    DBContract.SAC_FLIES: this.sacFlies,
    DBContract.STOLEN_BASES: this.stolenBases,
    DBContract.STRIKEOUTS: this.strikeOuts,
    DBContract.HBP: this.hbp,
    DBContract.GENDER: this.gender,
    DBContract.REACHED_ON_ERRORS: this.reachedOnErrors,
    DBContract.BATTING_ORDER: this.battingOrder
  };

  Map<String, dynamic> toFirestore() => {
    DBContract.FIRESTORE_ID: this.fireID,
    DBContract.TEAM_FIRESTORE_ID: this.teamFireID,
    DBContract.NAME: this.name,
    DBContract.TEAM: this.team,
    DBContract.GAMES: this.games,
    DBContract.RBI: this.rbi,
    DBContract.RUNS: this.runs,
    DBContract.SINGLES: this.singles,
    DBContract.DOUBLES: this.doubles,
    DBContract.TRIPLES: this.triples,
    DBContract.HRS: this.hrs,
    DBContract.OUTS: this.outs,
    DBContract.WALKS: this.walks,
    DBContract.SAC_FLIES: this.sacFlies,
    DBContract.STOLEN_BASES: this.stolenBases,
    DBContract.STRIKEOUTS: this.strikeOuts,
    DBContract.HBP: this.hbp,
    DBContract.GENDER: this.gender,
    DBContract.REACHED_ON_ERRORS: this.reachedOnErrors,
  };

  num getStat(String stat) {
    switch (stat) {
      case LABEL_G:
        return this.games;
      case LABEL_RBI:
        return this.rbi;
      case LABEL_R:
        return this.runs;
      case LABEL_1B:
        return this.singles;
      case LABEL_2B:
        return this.doubles;
      case LABEL_3B:
        return this.triples;
      case LABEL_HR:
        return this.hrs;
      case LABEL_OUT:
        return this.outs;
      case LABEL_BB:
        return this.walks;
      case LABEL_SF:
        return this.sacFlies;
      case LABEL_SB:
        return this.stolenBases;
      case LABEL_K:
        return this.strikeOuts;
      case LABEL_HBP:
        return this.hbp;
      case LABEL_ROE:
        return this.reachedOnErrors;
      case LABEL_H:
        return this.getHits();
      case LABEL_AB:
        return this.getAB();
      case LABEL_PA:
        return this.getPA();
      case LABEL_AVG:
        return this.getAVG();
      case LABEL_OBP:
        return this.getOBP();
      case LABEL_SLG:
        return this.getSLG();
      case LABEL_OPS:
        return this.getOPS();
      case LABEL_OBPROE:
        return this.getOBPwithROE();
      default:
        return 0;
    }
  }

  Map<String, num> toStatsMap() => {
        LABEL_G: this.games,
        LABEL_RBI: this.rbi,
        LABEL_R: this.runs,
        LABEL_1B: this.singles,
        LABEL_2B: this.doubles,
        LABEL_3B: this.triples,
        LABEL_HR: this.hrs,
        LABEL_OUT: this.outs,
        LABEL_BB: this.walks,
        LABEL_SF: this.sacFlies,
        LABEL_SB: this.stolenBases,
        LABEL_K: this.strikeOuts,
        LABEL_HBP: this.hbp,
        LABEL_ROE: this.reachedOnErrors,
        LABEL_H: this.getHits(),
        LABEL_AB: this.getAB(),
        LABEL_PA: this.getPA(),
        LABEL_AVG: this.getAVG(),
        LABEL_OBP: this.getOBP(),
        LABEL_SLG: this.getSLG(),
        LABEL_OPS: this.getOPS(),
        LABEL_OBPROE: this.getOBPwithROE(),
      };

  Player.fromJson(Map<String, dynamic> json) {
    this.id = json[DBContract.ID];
    this.fireID = json[DBContract.FIRESTORE_ID];
    this.teamFireID = json[DBContract.TEAM_FIRESTORE_ID];
    this.statkeeperFireID = json[DBContract.STATKEEPER_FIRESTORE_ID];
    this.name = json[DBContract.NAME];
    this.team = json[DBContract.TEAM];
    this.gender = json[DBContract.GENDER];
    this.games = json[DBContract.GAMES];
    this.singles = json[DBContract.SINGLES];
    this.doubles = json[DBContract.DOUBLES];
    this.triples = json[DBContract.TRIPLES];
    this.hrs = json[DBContract.HRS];
    this.walks = json[DBContract.WALKS];
    this.outs = json[DBContract.OUTS];
    this.sacFlies = json[DBContract.SAC_FLIES];
    this.reachedOnErrors = json[DBContract.REACHED_ON_ERRORS];
    this.strikeOuts = json[DBContract.STRIKEOUTS];
    this.stolenBases = json[DBContract.STOLEN_BASES];
    this.runs = json[DBContract.RUNS];
    this.rbi = json[DBContract.RBI];
    this.hbp = json[DBContract.HBP];
    this.battingOrder =  json[DBContract.BATTING_ORDER] ?? 99;
  }

  Player.fromFirestore(Map<String, dynamic> data, String sKID, String fireID) {
    this.fireID = fireID;
    this.teamFireID = data[DBContract.TEAM_FIRESTORE_ID];
    this.statkeeperFireID = sKID;
    this.name = data[DBContract.NAME];
    this.team = data[DBContract.TEAM];
    this.gender = data[DBContract.GENDER] ?? 0;
    this.games = data[DBContract.GAMES] ?? 0;
    this.singles = data[DBContract.SINGLES] ?? 0;
    this.doubles = data[DBContract.DOUBLES] ?? 0;
    this.triples = data[DBContract.TRIPLES] ?? 0;
    this.hrs = data[DBContract.HRS] ?? 0;
    this.walks = data[DBContract.WALKS] ?? 0;
    this.outs = data[DBContract.OUTS] ?? 0;
    this.sacFlies = data[DBContract.SAC_FLIES] ?? 0;
    this.reachedOnErrors = data[DBContract.REACHED_ON_ERRORS] ?? 0;
    this.strikeOuts = data[DBContract.STRIKEOUTS] ?? 0;
    this.stolenBases = data[DBContract.STOLEN_BASES] ?? 0;
    this.runs = data[DBContract.RUNS] ?? 0;
    this.rbi = data[DBContract.RBI] ?? 0;
    this.hbp = data[DBContract.HBP] ?? 0;
    this.battingOrder = this.battingOrder ?? 99;
  }

  int getHits() => singles + doubles + triples + hrs;

  int getTotalBases() => singles + doubles * 2 + triples * 3 + hrs * 4;

  int getOnBase() => getHits() + walks + hbp;

  int getOnBasePlusROE() => getOnBase() + reachedOnErrors;

  int getAB() => getHits() + outs + reachedOnErrors;

  int getPA() => getAB() + walks + sacFlies + hbp;

  double getAVG() {
    if (getAB() == 0) {
      return -1;
    } else {
      return getHits() / getAB();
    }
  }

  double getOBP() {
    if (getPA() == 0) {
      return -1;
    } else {
      return getOnBase() / getPA();
    }
  }

  double getSLG() {
    if (getAB() == 0) {
      return -1;
    } else {
      return getTotalBases() / getAB();
    }
  }

  double getOPS() {
    if (getSLG() < 0) {
      return getOBP();
    } else {
      return getSLG() + getOBP();
    }
  }

  double getOBPwithROE() {
    if (getPA() == 0) {
      return -1;
    } else {
      return getOnBasePlusROE() / getPA();
    }
  }

  static Comparator<Player> nameComparator() =>
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase());

  static Comparator<Player> teamComparator() =>
      (a, b) => b.team.toLowerCase().compareTo(a.team.toLowerCase());

  static Comparator<Player> gameComparator() =>
      (a, b) => b.games.compareTo(a.games);

  static Comparator<Player> singleComparator() =>
      (a, b) => b.singles.compareTo(a.singles);

  static Comparator<Player> doubleComparator() =>
      (a, b) => b.doubles.compareTo(a.doubles);

  static Comparator<Player> tripleComparator() =>
      (a, b) => b.triples.compareTo(a.triples);

  static Comparator<Player> hrComparator() => (a, b) => b.hrs.compareTo(a.hrs);

  static Comparator<Player> runComparator() =>
      (a, b) => b.runs.compareTo(a.runs);

  static Comparator<Player> rbiComparator() => (a, b) => b.rbi.compareTo(a.rbi);

  static Comparator<Player> walkComparator() =>
      (a, b) => b.walks.compareTo(a.walks);

  static Comparator<Player> outBaseComparator() =>
      (a, b) => b.outs.compareTo(a.outs);

  static Comparator<Player> sfComparator() =>
      (a, b) => b.sacFlies.compareTo(a.sacFlies);

  static Comparator<Player> stolenBaseComparator() =>
      (a, b) => b.stolenBases.compareTo(a.stolenBases);

  static Comparator<Player> roeComparator() =>
      (a, b) => b.reachedOnErrors.compareTo(a.reachedOnErrors);

  static Comparator<Player> kComparator() =>
      (a, b) => b.strikeOuts.compareTo(a.strikeOuts);

  static Comparator<Player> hbpComparator() => (a, b) => b.hbp.compareTo(a.hbp);

  static Comparator<Player> abComparator() =>
      (a, b) => b.getAB().compareTo(a.getAB());

  static Comparator<Player> paComparator() =>
      (a, b) => b.getPA().compareTo(a.getPA());

  static Comparator<Player> hitComparator() =>
      (a, b) => b.getHits().compareTo(a.getHits());

  static Comparator<Player> avgComparator() =>
      (a, b) => b.getAVG().compareTo(a.getAVG());

  static Comparator<Player> obpComparator() =>
      (a, b) => b.getOBP().compareTo(a.getOBP());

  static Comparator<Player> slgComparator() =>
      (a, b) => b.getSLG().compareTo(a.getSLG());

  static Comparator<Player> opsComparator() =>
      (a, b) => b.getOPS().compareTo(a.getOPS());

  static Comparator<Player> obproeComparator() =>
          (a, b) => b.getOBPwithROE().compareTo(a.getOBPwithROE());

  static Comparator<Player> lineupComparator() =>
          (a, b) => a.battingOrder.compareTo(b.battingOrder);

  static Map<String, Comparator<Player>> toComparatorMap() => {
        LABEL_NAME: nameComparator(),
        LABEL_TEAM: teamComparator(),
        LABEL_G: gameComparator(),
        LABEL_RBI: rbiComparator(),
        LABEL_R: runComparator(),
        LABEL_1B: singleComparator(),
        LABEL_2B: doubleComparator(),
        LABEL_3B: tripleComparator(),
        LABEL_HR: hrComparator(),
        LABEL_OUT: outBaseComparator(),
        LABEL_BB: walkComparator(),
        LABEL_SF: sfComparator(),
        LABEL_SB: stolenBaseComparator(),
        LABEL_K: kComparator(),
        LABEL_HBP: hbpComparator(),
        LABEL_ROE: roeComparator(),
        LABEL_H: hitComparator(),
        LABEL_AB: abComparator(),
        LABEL_PA: paComparator(),
        LABEL_AVG: avgComparator(),
        LABEL_OBP: obpComparator(),
        LABEL_SLG: slgComparator(),
        LABEL_OPS: opsComparator(),
        LABEL_OBPROE: obproeComparator(),
      };

  @override
  String toString() =>
      "Player $name  id:$id fireID:$fireID  sKID:$statkeeperFireID  teamID:$teamFireID";

  @override
  bool operator ==(other) => (identical(this, other) ||
      (other is Player && other.fireID == this.fireID));

  @override
  int get hashCode => this.fireID.hashCode;
}
