-----------------------------------
-- Area: Arrapago Remnants
--  NPC: Armoury Crate (Arrapago)
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    local npcID  = npc:getID()
    local first  = { 5367, 5371, 5383, 5384 }
    local second = { 5366, 5368, 5369, 5370, 5372, 5376, 5377, 5378, 5379, 5380, 5381, 5382 }

    player:addTreasure(5365) player:addTreasure(5365) player:addTreasure(5373) player:addTreasure(5375)
    player:addTreasure(5374) player:addTreasure(first[math.random(#first)]) player:addTreasure(first[math.random(#first)])
    player:addTreasure(second[math.random(#second)]) player:addTreasure(second[math.random(#second)])

    if math.random(1, 2) == 1 then
        player:addTreasure(5375)
    else
        player:addTreasure(5374)
    end

    GetNPCByID(npcID, instance):setStatus(xi.status.DISAPPEAR)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
