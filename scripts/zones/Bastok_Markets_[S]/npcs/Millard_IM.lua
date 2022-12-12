-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: Millard IM
-- Type: Sigil NPC
-- !pos -248.5 0 81.2 87
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets_[S]/IDs")
require("scripts/globals/campaign")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/extravaganza")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local notes = player:getCurrency("allied_notes")
    local freelances = 99 -- Faking it for now
    local cipher = xi.extravaganza.campaignActive() * 4
    -- 0 for not displaying ciphers
    -- 4 for Valaneiral (New Year's & Summer Alter Ego Extravaganzas)
    -- 8 for Adelheid (Spring & Autumn Alter Ego Extravaganzas)
    -- 12 to display both
    local medalRank = xi.campaign.getMedalRank(player)
    local bonusEffects = 0 -- 1 = regen, 2 = refresh, 4 = meal duration, 8 = exp loss reduction, 15 = all
    local timeStamp = 0 -- xi.campaign.getSigilTimeStamp(player)
    local allegiance = player:getCampaignAllegiance()

    -- if ( medal_rank > 25 and nation controls Throne_Room_S ) then
        -- medal_rank = 32
        -- this decides if allied ring is in the Allied Notes item list.
    -- end

    if medalRank == 0 then
        player:startEvent(14)
    else
        player:startEvent(13, allegiance, notes, freelances, cipher, medalRank, bonusEffects, timeStamp, 0)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- local itemid = 0
    local canEquip = 2 -- Faking it for now.
    -- 0 = Wrong job, 1 = wrong level, 2 = Everything is in order, 3 or greater = menu exits
    if csid == 13 and option >= 2 and option <= 2306 then
        -- itemid = getBastokNotesItem(option)
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, canEquip) -- canEquip(player, itemid));  <- works for sanction NPC, wtf?
    end
end

local optionList =
{
        1,  4097,  8193, 12289, 16385, 20481, 24577, 28673,
    36865, 40961, 45057, 49153, 53249, 57345, 61441,
}

entity.onEventFinish = function(player, csid, option)
    local medalRank = xi.campaign.getMedalRank(player)
    if csid == 13 then
        -- Note: the event itself already verifies the player has enough AN, so no check needed here.
        if option >= 2 and option <= 2306 then -- player bought item
            local item, price, adj = xi.campaign.getBastokNotesItem(option)
            --if player is allied with Bastok, they get adjusted price on most items
            if player:getCampaignAllegiance() == 2 and adj ~= nil then
                price = adj
            end

            if player:getFreeSlotsCount() >= 1 then
                player:delCurrency("allied_notes", price)
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item)
            else
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
            end

        -- Please, don't change this elseif without knowing ALL the option results first.
        elseif utils.contains(option, optionList) then
            local cost = 0
            local power = ((option - 1) / 4096)
            local duration = 10800 + ((15 * medalRank) * 60) -- 3hrs +15 min per medal (minimum 3hr 15 min with 1st medal)
            local subPower = 35 -- Sets % trigger for regen/refresh. Static at minimum value (35%) for now.

            if power == 1 or power == 2 or power == 4 then
            -- 1: Regen,  2: Refresh,  4: Meal Duration
                cost = 50
            elseif power == 3 or power == 5 or power == 6 or power == 8 or power == 12 then
            -- 3: Regen + Refresh,  5: Regen + Meal Duration,  6: Refresh + Meal Duration,
            -- 8: Reduced EXP loss,  12: Meal Duration + Reduced EXP loss
                cost = 100
            elseif
                power == 7 or
                power == 9 or
                power == 10 or
                power == 11 or
                power == 13 or
                power == 14
            then
            -- 7: Regen + Refresh + Meal Duration,  9: Regen + Reduced EXP loss,
            -- 10: Refresh + Reduced EXP loss,  11: Regen + Refresh + Reduced EXP loss,
            -- 13: Regen + Meal Duration + Reduced EXP loss,  14: Refresh + Meal Duration + Reduced EXP loss
                cost = 150
            elseif power == 15 then
            -- 15: Everything
                cost = 200
            end

            player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
            player:addStatusEffect(xi.effect.SIGIL, power, 0, duration, 0, subPower, 0)
            player:messageSpecial(ID.text.ALLIED_SIGIL)

            if cost > 0 then
                player:delCurrency("allied_notes", cost)
            end
        end
    end
end

return entity
