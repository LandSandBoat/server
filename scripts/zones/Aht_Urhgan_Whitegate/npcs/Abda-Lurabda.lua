-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Abda Lurabda
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getMainJob() == xi.job.PUP then
        player:startEvent(648, 0, 9800, player:getGil())
    else
        player:startEvent(257)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 648 and bit.band(option, 0x80000000) ~= 0 then
        player:delGil(9800)
        local page = bit.band(option, 0xF)
        local val = bit.rshift(bit.band(option, 0xFFFFF0), 4)
        player:setPetName(xi.petType.AUTOMATON, 86 + val + page * 32)
        player:messageSpecial(ID.text.AUTOMATON_RENAME)
    end
end

return entity
