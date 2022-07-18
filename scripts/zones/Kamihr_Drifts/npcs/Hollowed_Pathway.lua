-----------------------------------
-- Area: Kamihr Drifts
--  NPC: Hollowed Pathway
-- !pos -215.371 39.025 -446.368 267
-----------------------------------
require("scripts/globals/instance")
-----------------------------------
require('scripts/globals/zone')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.CIRDAS_CAVERNS_U) then
        --player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY) -- TODO: confirm this
    end
end

entity.onEventUpdate = function(player, csid, option)
    if xi.instance.onEventUpdate(player, csid, option) then
        if csid == 5511 and option == 844 then
            player:updateEvent(267, 16, 0, 1, 0, 0, 0, 1)
        elseif csid == 5511 and option == 4940 then
            player:updateEvent(267, 16, 0, 1, 0, 0, 0, 8)
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    xi.instance.onEventFinish(player, csid, option)
end

return entity
