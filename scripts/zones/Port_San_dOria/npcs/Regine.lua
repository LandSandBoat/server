-----------------------------------
-- Area: Port San d'Oria
--  NPC: Regine
-- Standard Merchant NPC
-- !pos 68 -9 -74 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    local flyersForRegine = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)
    local theBrugaireConsortium = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)

    -- FLYERS FOR REGINE
    if (flyersForRegine == QUEST_ACCEPTED and npcUtil.tradeHas( trade, {{"gil", 10}} )) then
        if (npcUtil.giveItem(player, 532)) then
            player:confirmTrade()
        end

    -- THE BRUGAIRE CONSORTIUM
    elseif (theBrugaireConsortium == QUEST_ACCEPTED and npcUtil.tradeHas(trade, 593)) then
        player:startEvent(535)
    end
end

function onTrigger(player, npc)
    local ffr = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)

    -- FLYERS FOR REGINE
    if ffr == QUEST_AVAILABLE then -- ready to accept quest
        player:startEvent(510, 2)
    elseif ffr == QUEST_ACCEPTED and not player:hasItem(532) then -- on quest but out of flyers
        player:startEvent(510, 3)
    elseif ffr == QUEST_ACCEPTED and player:getCharVar('[ffr]deliveryMask') == 32767 then -- all flyers delivered
        player:startEvent(603)

    -- DEFAULT MENU
    else
        player:startEvent(510)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- FLYERS FOR REGINE
    if csid == 510 and option == 2 then
        if npcUtil.giveItem(player, {{532, 12}, {532, 3}}) then
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)
        end
    elseif csid == 603 then
        npcUtil.completeQuest(
            player, SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE,
            {
                gil = 440,
                title = tpz.title.ADVERTISING_EXECUTIVE,
                var = '[ffr]deliveryMask',
            }
        )

    -- THE BRUGAIRE CONSORTIUM
    elseif (csid == 535) then
        player:confirmTrade()
        player:setCharVar("TheBrugaireConsortium-Parcels", 11)

    -- WHITE MAGIC SHOP
    elseif (csid == 510 and option == 0) then
        local stockA =
        {
            4641, 1165, 1, -- Scroll of Diaga
            4664, 837, 1,  -- Scroll of Slow
            4662, 7025, 1, -- Scroll of Stoneskin

            4636, 140, 2,  -- Scroll of Banish
            4646, 1165, 2, -- Scroll of Banishga
            4661, 2097, 2, -- Scroll of Blink
            4610, 585, 2,  -- Scroll of Cure II

            4663, 360, 3,  -- Scroll of Aquaveil
            4624, 990, 3,  -- Scroll of Blindna
            4615, 1363, 3, -- Scroll of Curaga
            4609, 61, 3,   -- Scroll of Cure
            4631, 82, 3,   -- Scroll of Dia
            4623, 324, 3,  -- Scroll of Paralyna
            4622, 180, 3,  -- Scroll of Poisona
            4651, 219, 3,  -- Scroll of Protect
            4656, 1584, 3  -- Scroll of Shell
        }
        tpz.shop.nation(player, stockA, tpz.nation.SANDORIA)

    -- BLACK MAGIC SHOP
    elseif (csid == 510 and option == 1) then
        local stockB =
        {
            4862, 111, 1,  -- Scroll of Blind
            4838, 360, 2,  -- Scroll of Bio
            4828, 82, 2,   -- Scroll of Poison
            4861, 2250, 2, -- Scroll of Sleep

            4762, 324, 3,  -- Scroll of Aero
            4757, 1584, 3, -- Scroll of Blizzard
            4843, 4644, 3, -- Scroll of Burn
            4845, 2250, 3, -- Scroll of Choke
            4848, 6366, 3, -- Scroll of Drown
            4752, 837, 3,  -- Scroll of Fire
            4844, 3688, 3, -- Scroll of Frost
            4846, 1827, 3, -- Scroll of Rasp
            4847, 1363, 3, -- Scroll of Shock
            4767, 61, 3,   -- Scroll of Stone
            4772, 3261, 3, -- Scroll of Thunder
            4777, 140, 3   -- Scroll of Water
        }
        tpz.shop.nation(player, stockB, tpz.nation.SANDORIA)
    end
end
