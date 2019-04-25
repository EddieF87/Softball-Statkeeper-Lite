import 'package:flutter/material.dart';
import 'package:sleekstats_flutter_statkeeper/model/player.dart';
import 'package:sleekstats_flutter_statkeeper/ui/team/player_stat_row.dart';
import 'package:sleekstats_flutter_statkeeper/ui/team/players_pageview.dart';
import 'package:sleekstats_flutter_statkeeper/ui/team/stats_header_row.dart';

class PlayersStatsTable extends StatefulWidget {
  final List<Player> players;
  final ValueSetter<String> onTeamLinkClicked;
  final bool isLeague;

  const PlayersStatsTable({
    Key key,
    this.players,
    this.onTeamLinkClicked,
    this.isLeague = false,
  }) : super(key: key);

  @override
  State<PlayersStatsTable> createState() => PlayersStatsTableState();
}

class PlayersStatsTableState extends State<PlayersStatsTable> {
  String statToSortBy = Player.LABEL_G;

  _sortPlayers(String stat) {
    Map<String, Comparator<Player>> comparatorMap = Player.toComparatorMap();
    if (comparatorMap.containsKey(stat)) {
      widget.players.sort(comparatorMap[stat]);
    } else {
      widget.players.sort(comparatorMap[Player.LABEL_G]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor, width: 4.0),
      ),
      child: widget.players.isEmpty
          ? Center(child: Text("Add players!"))
          : _buildStatsTable(context),
    );
  }

  Widget _buildStatsTable(BuildContext context) {
    debugPrint("_buildStatsTable");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: new Container(
        color: Colors.white,
        width: widget.isLeague ? 1320.0 : 1250.0,
        child: Column(
          children: <Widget>[
            StatsHeaderRow(
              statSorted: statToSortBy,
              onStatSelected: (statLabel) => setState(() {
                    statToSortBy = statLabel;
                  }),
              isLeague: widget.isLeague,
            ),
            Expanded(
              child: _buildList(context, statToSortBy),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, String stat) {
    _sortPlayers(stat);

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => PlayerStatRow(
            isLeague: widget.isLeague,
            player: widget.players[index],
            isColoredRow: index.isOdd,
            onPlayerSelected: () => _navigateToPlayersPageView(context, index),
            onTeamSelected: (String teamFireID) =>
                widget.onTeamLinkClicked(teamFireID),
          ),
      itemCount: widget.players.length,
    );
  }

  /// Navigates to the PageView of players.
  void _navigateToPlayersPageView(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return PlayersPageView(
            players: widget.players,
            startingIndex: index,
          );
        },
      ),
    );
  }
}
