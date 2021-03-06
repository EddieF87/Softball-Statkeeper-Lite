import 'package:flutter/material.dart';
import 'package:sleekstats_flutter_statkeeper/database/moor_tables.dart';
import 'package:sleekstats_flutter_statkeeper/model/player_utils.dart';
import 'package:sleekstats_flutter_statkeeper/ui/team/stat_cell.dart';

class PlayerStatRow extends StatelessWidget {
  final Player player;
  final bool isColoredRow;
  final bool isLeague;
  final VoidCallback onPlayerSelected;
  final ValueSetter<String> onTeamSelected;

  const PlayerStatRow({
    this.player,
    this.isColoredRow = false,
    this.onPlayerSelected,
    this.onTeamSelected,
    this.isLeague = false,
  }) : assert(player != null);

  @override
  Widget build(BuildContext context) {
    Color primaryColorLight = Theme.of(context).primaryColorLight;

    return Container(
      color: isColoredRow ? primaryColorLight : null,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => onPlayerSelected(),
            child: StatCell(
              data: player.name,
              width: 100.0,
              fontWeight: FontWeight.bold,
              textColor: player.gender == 0
                  ? StatCellTextColor.BOY
                  : StatCellTextColor.GIRL,
            ),
          ),
          isLeague
              ? InkWell(
                  onTap: () => onTeamSelected(player.teamfirestoreid),
                  child: StatCell(data: player.team, width: 70.0),
                )
              : new Container(),
          StatCell(data: player.games),
          StatCell(data: player.getPA()),
          StatCell(data: player.getAB()),
          StatCell(data: player.getHits()),
          StatCell(data: player.singles),
          StatCell(data: player.doubles),
          StatCell(data: player.triples),
          StatCell(data: player.hrs),
          StatCell(data: player.runs),
          StatCell(data: player.rbis),
          StatCell(statName: PlayerUtils.LABEL_AVG, data: player.getAVG(), width: 70.0),
          StatCell(statName: PlayerUtils.LABEL_OBP, data: player.getOBP(), width: 70.0),
          StatCell(statName: PlayerUtils.LABEL_SLG, data: player.getSLG(), width: 70.0),
          StatCell(statName: PlayerUtils.LABEL_OPS, data: player.getOPS(), width: 70.0),
          StatCell(statName: PlayerUtils.LABEL_OBPROE, data: player.getOBPwithROE(), width: 70.0),
          StatCell(data: player.walks),
          StatCell(data: player.stolenBases),
          StatCell(data: player.outs),
          StatCell(data: player.sacFlies),
          StatCell(data: player.reachedOnErrors),
          StatCell(data: player.strikeouts),
        ],
      ),
    );
  }
}
