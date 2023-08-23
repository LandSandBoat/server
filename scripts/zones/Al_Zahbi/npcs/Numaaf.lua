-----------------------------------
-- Area: Al Zahbi
--  NPC: Numaaf
-- Type: Cooking Normal/Adv. Image Support
-- !pos 54.966 -7 8.328 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.COOKING) then
        if
            trade:hasItemQty(xi.item.IMPERIAL_BRONZE_PIECE, 1) and
            trade:getItemCount() == 1
        then
            if not player:hasStatusEffect(xi.effect.COOKING_IMAGERY) then
                player:tradeComplete()
                player:startEvent(223, 8, 0, 0, 0, 188, 0, 8, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.COOKING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.COOKING) then
        if not player:hasStatusEffect(xi.effect.COOKING_IMAGERY) then
            player:startEvent(222, 8, skillLevel, 0, 511, 188, 0, 8, xi.item.IMPERIAL_BRONZE_PIECE)
        else
            player:startEvent(222, 8, skillLevel, 0, 511, 188, 7121, 8, xi.item.IMPERIAL_BRONZE_PIECE)
        end
    else
        player:startEvent(222, 0, 0, 0, 0, 0, 0, 8, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 222 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 8, 1)
        player:addStatusEffect(xi.effect.COOKING_IMAGERY, 1, 0, 120)
    elseif csid == 223 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 8, 0)
        player:addStatusEffect(xi.effect.COOKING_IMAGERY, 3, 0, 480)
    end
end

return entity
