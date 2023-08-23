-----------------------------------
-- Area: Al Zahbi
--  NPC: Nudahaal
-- Type: Bonecraft Normal/Adv. Image Support
-- !pos -57.056 -7 -88.377 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.BONECRAFT) then
        if
            trade:hasItemQty(xi.item.IMPERIAL_BRONZE_PIECE, 1) and
            trade:getItemCount() == 1
        then
            if not player:hasStatusEffect(xi.effect.BONECRAFT_IMAGERY) then
                player:tradeComplete()
                player:startEvent(225, 8, 0, 0, 0, 188, 0, 6, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.BONECRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.BONECRAFT) then
        if not player:hasStatusEffect(xi.effect.BONECRAFT_IMAGERY) then
            player:startEvent(224, 8, skillLevel, 0, 511, 188, 0, 6, xi.item.IMPERIAL_BRONZE_PIECE)
        else
            player:startEvent(224, 8, skillLevel, 0, 511, 188, 7121, 6, xi.item.IMPERIAL_BRONZE_PIECE)
        end
    else
        player:startEvent(224, 0, 0, 0, 0, 0, 0, 6, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 224 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 1)
        player:addStatusEffect(xi.effect.BONECRAFT_IMAGERY, 1, 0, 120)
    elseif csid == 225 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 6, 0)
        player:addStatusEffect(xi.effect.BONECRAFT_IMAGERY, 3, 0, 480)
    end
end

return entity
