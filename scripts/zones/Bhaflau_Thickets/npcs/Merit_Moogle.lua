-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: Merit Moogle
-----------------------------------
require('modules/custom/lua/mentor')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local plevel = player:getMainLvl()
    local yPos = player:getYPos()

    -- Handle teleport for players below the platform
    if yPos > -10.903 then
        if player:getLocalVar('MogBoost') == 0 then
            player:printToPlayer('LOL Y U DOWN DERE? If you want, talk to me again to come up', xi.msg.channel.SAY, 'Merit Moogle')
            player:setLocalVar('MogBoost', 1)
        else
            player:setPos(-566.592, -11.683, -40.336)
            player:printToPlayer('You\'re heavy, but my Moogle magic is stronger!', xi.msg.channel.SAY, 'Merit Moogle')
            player:setLocalVar('MogBoost', 0)
        end

        return
    end

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
