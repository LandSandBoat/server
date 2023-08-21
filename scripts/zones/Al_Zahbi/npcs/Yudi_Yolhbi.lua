-----------------------------------
-- Area: Al Zahbi
--  NPC: Yudi Yolhbi
-- Type: Woodworking Normal/Adv. Image Support
-- !pos -71.584 -7 -56.018 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.WOODWORKING) then
        if
            trade:hasItemQty(xi.item.IMPERIAL_BRONZE_PIECE, 1) and
            trade:getItemCount() == 1
        then
            if not player:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) then
                player:tradeComplete()
                player:startEvent(235, 8, 0, 0, 0, 188, 0, 1, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.WOODWORKING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.WOODWORKING) then
        if not player:hasStatusEffect(xi.effect.WOODWORKING_IMAGERY) then
            player:startEvent(234, 8, skillLevel, 0, 511, 188, 0, 1, xi.item.IMPERIAL_BRONZE_PIECE)
        else
            player:startEvent(234, 8, skillLevel, 0, 511, 188, 7055, 1, xi.item.IMPERIAL_BRONZE_PIECE)
        end
    else
        player:startEvent(234, 0, 0, 0, 0, 0, 0, 1, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 234 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 1)
        player:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 1, 0, 120)
    elseif csid == 235 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 0)
        player:addStatusEffect(xi.effect.WOODWORKING_IMAGERY, 3, 0, 480)
    end
end

return entity
