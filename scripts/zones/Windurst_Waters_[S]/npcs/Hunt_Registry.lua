require("scripts/globals/hunts")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc, event)
  tpz.hunts.onTrigger(player, npc, event)
end

function onEventUpdate(player, csid, option)
  tpz.hunts.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
  tpz.hunts.onEventFinish(player, csid, option)
end
