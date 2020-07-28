-----------------------------------
-- Area: Arrapago Remnants
-- NPC: Armoury Crate (Arrapago)
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    local instance = npc:getInstance()
    local npc = npc:getID()
    local FIRST = {5367, 5371, 5383, 5384}
    local SECOND = {5366, 5368, 5369, 5370, 5372, 5376, 5377, 5378, 5379, 5380, 5381, 5382}
    player:addTreasure(5365) player:addTreasure(5365) player:addTreasure(5373) player:addTreasure(5375)
    player:addTreasure(5374) player:addTreasure(FIRST[math.random(#FIRST)]) player:addTreasure(FIRST[math.random(#FIRST)])
    player:addTreasure(SECOND[math.random(#SECOND)]) player:addTreasure(SECOND[math.random(#SECOND)])

    if math.random(1, 2) == 1 then
        player:addTreasure(5375)
    else
        player:addTreasure(5374)
    end
    instance:getEntity(bit.band(npc, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.DISAPPEAR)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(entity, eventid, result, door)
end
