-----------------------------------
-- Area: Qufim Island (126)
--  NPC: Transcendental Radiance
-- !pos -259.433 -21.581 220.498 126
-- Warp to Abyssea - Empyreal Paradox.
-- Requires Beneath a Blood Red Sky accepted or completed.
-- Entry: Crimson Traverser Stone (free) or 1+ Traverser Stone and 10000+ cruor.
-- Event 46 = completed quest dialogue; Event 47 = accepted (not completed) dialogue.
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local status = player:getQuestStatus(xi.questLog.ABYSSEA, xi.quest.id.abyssea.BENEATH_A_BLOOD_RED_SKY)
    if status < xi.questStatus.QUEST_ACCEPTED then
        return
    end

    local hasCrimson = player:hasKeyItem(xi.ki.CRIMSON_TRAVERSER_STONE)
    local traverserStones = xi.abyssea.getHeldTraverserStones(player)
    local cruor = player:getCurrency('cruor')

    if not hasCrimson and (traverserStones < 1 or cruor < 10000) then
        return
    end

    if status >= xi.questStatus.QUEST_COMPLETED then
        player:startEvent(46, 0, 0, cruor, 10000, 0, 0, 0)
    else
        player:startEvent(47, 0, 0, cruor, 10000, 0, 0, 0)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    local cruor = player:getCurrency('cruor')
    player:updateEvent(7, 1, cruor, 10000, 0, 848559, 4095, 131186)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option ~= 1 then
        return
    end

    if not player:hasKeyItem(xi.ki.CRIMSON_TRAVERSER_STONE) then
        if
            player:getCurrency('cruor') >= 10000 and
            xi.abyssea.getHeldTraverserStones(player) >= 1
        then
            player:delCurrency('cruor', 10000)
            npcUtil.giveKeyItem(player, xi.ki.CRIMSON_TRAVERSER_STONE)
            xi.abyssea.spendTravStones(player, 1)
        else
            return
        end
    end

    player:setPos(540, -500, -571, 64, xi.zone.ABYSSEA_EMPYREAL_PARADOX)
end

return entity
