-----------------------------------
-- Area: Al Zahbi
--  NPC: Gidappa
-- Type: Clothcraft Normal/Adv. Image Support
-- !pos 70.228 -7 -54.089 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.CLOTHCRAFT) then
        if
            trade:hasItemQty(xi.item.IMPERIAL_BRONZE_PIECE, 1) and
            trade:getItemCount() == 1
        then
            if not player:hasStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY) then
                player:tradeComplete()
                player:startEvent(229, 8, 0, 0, 0, 188, 0, 4, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.CLOTHCRAFT)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.CLOTHCRAFT) then
        if not player:hasStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY) then
            player:startEvent(228, 8, skillLevel, 0, 511, 188, 0, 4, xi.item.IMPERIAL_BRONZE_PIECE)
        else
            player:startEvent(228, 8, skillLevel, 0, 511, 188, 7127, 4, xi.item.IMPERIAL_BRONZE_PIECE)
        end
    else
        player:startEvent(228, 0, 0, 0, 0, 0, 0, 4, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 228 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 1)
        player:addStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY, 1, 0, 120)
    elseif csid == 229 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 0)
        player:addStatusEffect(xi.effect.CLOTHCRAFT_IMAGERY, 3, 0, 480)
    end
end

return entity
