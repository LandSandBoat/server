-----------------------------------
-- Area: Windurst Woods
--  NPC: Samigo-Pormigo
-- Type: Guildworker's Union Representative
-- !pos -9.782 -5.249 -134.432 241
-----------------------------------
local ID = zones[xi.zone.WINDURST_WOODS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.crafting.guildPointOnTrade(player, npc, trade, 10023, 6)
end

entity.onTrigger = function(player, npc)
    xi.crafting.guildPointOnTrigger(player, 10022, 6)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 6)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.guildPointOnEventFinish(player, option, npc, 6)
    elseif csid == 10023 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
