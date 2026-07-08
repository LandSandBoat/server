-----------------------------------
-- Area: North Gustaberg
--  NPC: qm1 (???)
-- Involved in Quest "The Siren's Tear"
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(10)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10 and option == 0 then
        if
            player:getEquipID(xi.slot.MAIN) == 0 and
            player:getEquipID(xi.slot.SUB) == 0
        then
            if player:hasItem(xi.item.SIRENS_TEAR) or player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.SHINING_OBJECT_SLIPS_AWAY)
            else
                npcUtil.giveItem(player, xi.item.SIRENS_TEAR)
            end
        else
            player:messageSpecial(ID.text.SHINING_OBJECT_SLIPS_AWAY)
        end

        -- Siren's tear moves no matter what. and it can pick the same position twice. It doesnt seem to have a logical pattern after testing about 20 positions.
        npc:setPos(unpack(ID.positions.sirensTear[math.randomInt(1, #ID.positions.sirensTear)]))
    end
end

return entity
