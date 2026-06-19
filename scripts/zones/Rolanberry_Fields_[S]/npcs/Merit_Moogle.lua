-----------------------------------
-- Area: Rolanberry Fields [S]
--  NPC: Merit Moogle
-----------------------------------
require('modules/custom/lua/mentor')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local plevel = player:getMainLvl()

    if plevel >= 74 and player:getPartySize() >= 3 then
        if player:getCharVar('MentorFlag') == 1 then
            xi.mentor.meritMoogleMentor(player, npc)
        else
            xi.mentor.meritMoogle(player, npc)
        end
    else
        player:printToPlayer('You need to be level 74+ and in a party of 3+ to use Era Merit Moogle', xi.msg.channel.SAY, 'Merit Moogle')
    end
end

return entity
