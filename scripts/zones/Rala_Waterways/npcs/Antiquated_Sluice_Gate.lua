-----------------------------------
-- Area: Rala Waterways (258)
--  NPC: Antiquated_Sluice_Gate
-- !pos -529.361 -7.000 59.988 258
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- player:startEvent(5511, 0, 8)
    if not xi.instance.onTrigger(player, npc, xi.zone.RALA_WATERWAYS_U) then
        --player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY) -- TODO: confirm this
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    -- TODO if instance creation fails, the player will be stuck in a cutscene
    if xi.instance.onEventUpdate(player, csid, option, npc) then
        if csid == 5511 and option == 843 then
            print(1)
            player:updateEvent(258, 8, 0, 1, 0, 0, 0, 1)
        elseif csid == 5511 and option == 4939 then
            print(2)
            player:updateEvent(258, 8, 0, 1, 0, 0, 0, 8)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.instance.onEventFinish(player, csid, option, npc)
end

return entity
