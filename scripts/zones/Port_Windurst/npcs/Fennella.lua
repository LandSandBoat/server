-----------------------------------
-- Area: Port Windurst
--  NPC: Fennella
-- Type: Guildworker's Union Representative
-- !pos -177.811 -2.835 65.639 240
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 10021, 0)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 10020, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 0)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 0)
    elseif csid == 10021 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
