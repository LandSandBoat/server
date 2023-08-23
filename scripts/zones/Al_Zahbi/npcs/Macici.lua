-----------------------------------
-- Area: Al Zahbi
--  NPC: Macici
-- Type: Smithing Normal/Adv. Image Support
-- !pos -35.163 -1 -31.351 48
-----------------------------------
local ID = zones[xi.zone.AL_ZAHBI]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.SMITHING) then
        if
            trade:hasItemQty(xi.item.IMPERIAL_BRONZE_PIECE, 1) and
            trade:getItemCount() == 1
        then
            if not player:hasStatusEffect(xi.effect.SMITHING_IMAGERY) then
                player:tradeComplete()
                player:startEvent(233, 8, 0, 0, 0, 188, 0, 2, 0)
            else
                npc:showText(npc, ID.text.IMAGE_SUPPORT_ACTIVE)
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local skillLevel = player:getSkillLevel(xi.skill.SMITHING)

    if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.SMITHING) then
        if not player:hasStatusEffect(xi.effect.SMITHING_IMAGERY) then
            player:startEvent(232, 8, skillLevel, 0, 511, 188, 0, 2, xi.item.IMPERIAL_BRONZE_PIECE)
        else
            player:startEvent(232, 8, skillLevel, 0, 511, 188, 6566, 2, xi.item.IMPERIAL_BRONZE_PIECE)
        end
    else
        player:startEvent(232, 0, 0, 0, 0, 0, 0, 2, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 232 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 1)
        player:addStatusEffect(xi.effect.SMITHING_IMAGERY, 1, 0, 120)
    elseif csid == 233 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 0)
        player:addStatusEffect(xi.effect.SMITHING_IMAGERY, 3, 0, 480)
    end
end

return entity
