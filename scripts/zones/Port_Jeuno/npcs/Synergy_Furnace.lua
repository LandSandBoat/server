-----------------------------------
-- Area: Port Jeuno
--  NPC: Synergy Furnace
-- !pos  -52 0 -11 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local function handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)
    if v2 == -1 then
        a2 = nil
        v2 = nil
    end
    if v3 == -1 then
        a3 = nil
        v3 = nil
    end
    if v4 == -1 then
        a4 = nil
        v4 = nil
    end

    player:tradeComplete()
    player:addItem(itemId,1,a1,v1,a2,v2,a3,v3,a4,v4)
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId)
end

entity.onTrade = function(player, npc, trade)
    -- Initialize local variables.
    local itemId = 0
    local a1 = 0
    local a2 = 0
    local a3 = 0
    local a4 = 0
    local v1 = 0
    local v2 = 0
    local v3 = 0
    local v4 = 0

    -- *Genbu's Kabuto*
    if npcUtil.tradeHasExactly(trade, {12434, 3275}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12434

        a1 = 49
        a2 = 54
        a3 = 195
        a4 = 53
        v1 = math.random(3)    -- + 1-4% Haste. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3 Physical Damage Taken -1%
        v3 = math.random(-1,3) -- + 0-4 Subtle Blow
        v4 = math.random(-1,5) -- + 0-6 Spell interruption rate down 1%

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Genbu's Shield*
    elseif npcUtil.tradeHasExactly(trade, {12296, 3275}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12296

        a1 = 329
        a2 = 35
        a3 = 323
        a4 = 9
        v1 = math.random(4)     -- + 1-5% Cure Potency. Guaranteed.
        v2 = math.random(-1,5)  -- + 0-6 Magic Accuracy
        v3 = math.random(-1,7)  -- - 0-8% Cure Spellcasting Time
        v4 = math.random(-1,31) -- + 0-32 MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Suzaku's Sune-Ate*
    elseif npcUtil.tradeHasExactly(trade, {12946, 3276}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12946

        a1 = 49
        a2 = 140
        a3 = 134
        a4 = 37
        v1 = math.random(2)    -- + 1-3% Haste. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4 Fast Cast
        v3 = math.random(-1,2) -- + 0-3 Magic Def. Bonus
        v4 = math.random(-1,4) -- + 0-5 Magic Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Suzaku's Scythe*
    elseif npcUtil.tradeHasExactly(trade, {18043, 3276}) and player:getFreeSlotsCount() >= 1 then
        itemId = 18043

        a1 = 45
        a2 = 49
        a3 = 512
        a4 = 516
        v1 = math.random(17,26) -- + 18-27 Base Damage. Guaranteed.
        v2 = math.random(-1,1)  -- + 0-2% Haste
        v3 = math.random(-1,4)  -- + 0-5 STR
        v4 = math.random(-1,4)  -- + 0-5 INT

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Byakko's Haidate*
    elseif npcUtil.tradeHasExactly(trade, {12818, 3278}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12818

        a1 = 142
        a2 = 328
        a3 = 514
        a4 = 515
        v1 = math.random(4)    -- + 1-5 Store TP. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4% Crit. Hit Damage
        v3 = math.random(-1,5) -- + 0-6 VIT
        v4 = math.random(-1,5) -- + 0-6 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Byakko's Axe*
    elseif npcUtil.tradeHasExactly(trade, {18198, 3278}) and player:getFreeSlotsCount() >= 1 then
        itemId = 18198

        a1 = 45
        a2 = 41
        a3 = 514
        a4 = 513
        v1 = math.random(17,23) -- + 18-24 Base DMG. Guaranteed.
        v2 = math.random(-1,2)  -- + 0-3 Crit. Hit Rate
        v3 = math.random(-1,4)  -- + 0-5 VIT
        v4 = math.random(-1,4)  -- + 0-5 DEX

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Seiryu's Kote*
    elseif npcUtil.tradeHasExactly(trade, {12690, 3277}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12690

        a1 = 142
        a2 = 41
        a3 = 25
        a4 = 23
        v1 = math.random(4)    -- + 1-5 Store TP. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3 Crit. Hit Rate
        v3 = math.random(-1,4) -- + 0-5 Attack
        v4 = math.random(-1,4) -- + 0-5 Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Seiryu's Sword*
    elseif npcUtil.tradeHasExactly(trade, {17659, 3277}) and player:getFreeSlotsCount() >= 1 then
        itemId = 17659

        a1 = 45
        a2 = 146
        a3 = 23
        a4 = 259
        v1 = math.random(9)    -- + 1-10 Base DMG. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3 Dual Weild
        v3 = math.random(-1,6) -- + 0-7 Accuracy
        v4 = math.random(-1,4) -- + 0-5 Sword Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Osode (Genbu)*
    elseif npcUtil.tradeHasExactly(trade, {12562, 3275}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12562

        a1 = 137
        a2 = 54
        a3 = 25
        a4 = 23
        v1 = math.random(1)    -- + 1-2 Regen. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Physical Damage Taken -1%
        v3 = math.random(-1,6) -- + 0-7 Attack
        v4 = math.random(-1,6) -- + 0-7 Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Osode (Suzaku)*
    elseif npcUtil.tradeHasExactly(trade, {12562, 3276}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12562

        a1 = 143
        a2 = 328
        a3 = 25
        a4 = 23
        v1 = math.random(1)    -- + 1-2 Double Attack. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3% Crit. Hit Damage
        v3 = math.random(-1,6) -- + 0-7 Attack
        v4 = math.random(-1,6) -- + 0-7 Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Osode (Byakko)*
    elseif npcUtil.tradeHasExactly(trade, {12562, 3278}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12562

        a1 = 146
        a2 = 41
        a3 = 25
        a4 = 23
        v1 = math.random(2)    -- + 1-3 Dual Weild. Guaranteed.
        v2 = math.random(-1,1) -- + 0-2% Crit. Hit Rate
        v3 = math.random(-1,6) -- + 0-7 Attack
        v4 = math.random(-1,6) -- + 0-7 Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Osode (Seiryu)*
    elseif npcUtil.tradeHasExactly(trade, {12562, 3277}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12562

        a1 = 211
        a2 = 29
        a3 = 31
        a4 = 23
        v1 = math.random(3)    -- + 1-4 Snapshot. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 Ranged Attack
        v3 = math.random(-1,6) -- + 0-7 Evasion
        v4 = math.random(-1,6) -- + 0-7 Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Pole (Genbu)*
    elseif npcUtil.tradeHasExactly(trade, {17567, 3275}) and player:getFreeSlotsCount() >= 1 then
        itemId = 17567

        a1 = 45
        a2 = 25
        a3 = 23
        a4 = 290
        v1 = math.random(17,27) -- + 18-28 Base DMG. Guaranteed.
        v2 = math.random(-1,4)  -- + 0-5 Attack
        v3 = math.random(-1,4)  -- + 0-5 Accuracy
        v4 = math.random(-1,11) -- + 0-12 Enhancing Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Pole (Suzaku)*
    elseif npcUtil.tradeHasExactly(trade, {17567, 3276}) and player:getFreeSlotsCount() >= 1 then
        itemId = 17567

        a1 = 45
        a2 = 25
        a3 = 23
        a4 = 292
        v1 = math.random(17,27) -- + 18-28 Base DMG. Guaranteed.
        v2 = math.random(-1,4)  -- + 0-5 Attack
        v3 = math.random(-1,4)  -- + 0-5 Accuracy
        v4 = math.random(-1,11) -- + 0-12 Elemental Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Pole (Byakko)*
    elseif npcUtil.tradeHasExactly(trade, {17567, 3278}) and player:getFreeSlotsCount() >= 1 then
        itemId = 17567

        a1 = 45
        a2 = 25
        a3 = 23
        a4 = 294
        v1 = math.random(17,27) -- + 18-28 Base DMG. Guaranteed.
        v2 = math.random(-1,4)  -- + 0-5 Attack
        v3 = math.random(-1,4)  -- + 0-5 Accuracy
        v4 = math.random(-1,11) -- + 0-12 Summoning Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kirin's Pole (Seiryu)*
    elseif npcUtil.tradeHasExactly(trade, {17567, 3277}) and player:getFreeSlotsCount() >= 1 then
        itemId = 17567

        a1 = 45
        a2 = 25
        a3 = 23
        a4 = 291
        v1 = math.random(17,27) -- + 18-28 Base DMG. Guaranteed.
        v2 = math.random(-1,4)  -- + 0-5 Attack
        v3 = math.random(-1,4)  -- + 0-5 Accuracy
        v4 = math.random(-1,11) -- + 0-12 Enfeebling Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Crown*
    elseif npcUtil.tradeHasExactly(trade, {13876, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13876

        a1 = 133
        a2 = 57
        a3 = 290
        a4 = 293
        v1 = math.random(4)    -- + 1-5 Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5% Magic Crit. Hit Rate
        v3 = math.random(-1,7) -- + 0-8 Enhancing Magic Skill
        v4 = math.random(-1,7) -- + 0-8 Dark Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Dalmatica*
    elseif npcUtil.tradeHasExactly(trade, {13787, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13787

        a1 = 351
        a2 = 140
        a3 = 133
        a4 = 35
        v1 = math.random(2)    -- + 1-3% Occasionally Quickens Spellcasting. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Fast Cast
        v3 = math.random(-1,5) -- + 0-6 Magic Attack Bonus
        v4 = math.random(-1,5) -- + 0-6 Magic Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Mitts*
    elseif npcUtil.tradeHasExactly(trade, {14006, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14006

        a1 = 516
        a2 = 40
        a3 = 334
        a4 = 141
        v1 = math.random(5)    -- + 1-6 INT. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Enmity -
        v3 = math.random(-1,9) -- + 0-10% Magic Burst Damage
        v4 = math.random(-1,4) -- + 0-5 Conserve MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Slacks*
    elseif npcUtil.tradeHasExactly(trade, {14247, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14247

        a1 = 322
        a2 = 298
        a3 = 1
        a4 = 9
        v1 = math.random(3)     -- + 1-4% Song Spellcasting Time -. Guaranteed.
        v2 = math.random(-1,6)  -- + 1-7 Wind Instrument Skill
        v3 = math.random(-1,24) -- + 0-25 HP
        v4 = math.random(-1,24) -- + 0-25 MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Pumps*
    elseif npcUtil.tradeHasExactly(trade, {14123, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14123

        a1 = 294
        a2 = 329
        a3 = 323
        a4 = 289
        v1 = math.random(6)    -- + 1-7 Summoning Magic Skill. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4% Cure Potency
        v3 = math.random(-1,7) -- + 0-8% Cure Spellcasting Time -
        v4 = math.random(-1,5) -- + 0-6 Healing Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Crown +1*
    elseif npcUtil.tradeHasExactly(trade, {13877, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13877

        a1 = 133
        a2 = 57
        a3 = 290
        a4 = 293
        v1 = math.random(4)    -- + 1-5 Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5% Magic Crit. Hit Rate
        v3 = math.random(-1,7) -- + 0-8 Enhancing Magic Skill
        v4 = math.random(-1,7) -- + 0-8 Dark Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Dalmatica +1*
    elseif npcUtil.tradeHasExactly(trade, {13788, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13788

        a1 = 351
        a2 = 140
        a3 = 133
        a4 = 35
        v1 = math.random(2)    -- + 1-3% Occasionally Quickens Spellcasting. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Fast Cast
        v3 = math.random(-1,5) -- + 0-6 Magic Attack Bonus
        v4 = math.random(-1,5) -- + 0-6 Magic Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Mitts +1*
    elseif npcUtil.tradeHasExactly(trade, {14007, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14007

        a1 = 516
        a2 = 40
        a3 = 334
        a4 = 141
        v1 = math.random(5)    -- + 1-6 INT. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Enmity -
        v3 = math.random(-1,9) -- + 0-10% Magic Burst Damage
        v4 = math.random(-1,4) -- + 0-5 Conserve MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Slacks +1*
    elseif npcUtil.tradeHasExactly(trade, {14248, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14248

        a1 = 322
        a2 = 298
        a3 = 1
        a4 = 9
        v1 = math.random(3)     -- + 1-4% Song Spellcasting Time -. Guaranteed.
        v2 = math.random(-1,6)  -- + 0-7 Wind Instrument Skill
        v3 = math.random(-1,24) -- + 0-25 HP
        v4 = math.random(-1,24) -- + 0-25 MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Zenith Pumps +1*
    elseif npcUtil.tradeHasExactly(trade, {14124, 3283}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14124

        a1 = 294
        a2 = 329
        a3 = 323
        a4 = 289
        v2 = math.random(-1,3) -- + 0-4% Cure Potency
        v3 = math.random(-1,7) -- + 0-8% Cure Spellcasting Time -
        v4 = math.random(-1,5) -- + 0-6 Healing Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Zunari Kabuto*
    elseif npcUtil.tradeHasExactly(trade, {13934, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13934

        a1 = 327
        a2 = 332
        a3 = 333
        a4 = 25
        v1 = math.random(2)    -- + 1-3% Weapon Skill Damage. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3% Skillchain Damage
        v3 = math.random(-1,5) -- + 0-6 Conserve TP
        v4 = math.random(-1,6) -- + 0-7 Attack

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Togi*
    elseif npcUtil.tradeHasExactly(trade, {14387, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14387

        a1 = 49
        a2 = 41
        a3 = 215
        a4 = 31
        v1 = math.random(2)    -- + 1-3% Haste. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3 Crit. Hit rate
        v3 = math.random(-1,4) -- + 0-5 Ninja Tool Expertise
        v4 = math.random(-1,6) -- + 0-7 Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Kote*
    elseif npcUtil.tradeHasExactly(trade, {14821, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14821

        a1 = 145
        a2 = 31
        a3 = 53
        a4 = 515
        v1 = math.random(3)    -- + 1-4 Counter. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Evasion
        v3 = math.random(-1,4) -- + 0-5% Spell Interruption Rate Down
        v4 = math.random(-1,6) -- + 0-7 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Haidate*
    elseif npcUtil.tradeHasExactly(trade, {14303, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14303

        a1 = 146
        a2 = 39
        a3 = 142
        a4 = 515
        v1 = math.random(4)    -- + 1-5 Dual Weild. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Enmity
        v3 = math.random(-1,4) -- + 0-5 Store TP
        v4 = math.random(-1,5) -- + 0-6 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Sune-Ate*
    elseif npcUtil.tradeHasExactly(trade, {14184, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14184

        a1 = 194
        a2 = 143
        a3 = 512
        a4 = 515
        v1 = math.random(3)    -- + 1-4 Kick Attacks. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3 Double Attack
        v3 = math.random(-1,4) -- + 0-5 STR
        v4 = math.random(-1,4) -- + 0-5 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Zunari Kabuto +1*
    elseif npcUtil.tradeHasExactly(trade, {13935, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13935

        a1 = 327
        a2 = 332
        a3 = 333
        a4 = 25
        v1 = math.random(2)    -- + 1-3% Weapon Skill Damage. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3% Skillchain Damage
        v3 = math.random(-1,5) -- + 0-6 Conserve TP
        v4 = math.random(-1,6) -- + 0-7 Attack

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Togi +1*
    elseif npcUtil.tradeHasExactly(trade, {14388, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14388

        a1 = 49
        a2 = 41
        a3 = 215
        a4 = 31
        v1 = math.random(2)    -- + 1-3% Haste. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3 Crit. Hit rate
        v3 = math.random(-1,4) -- + 0-5 Ninja Tool Expertise
        v4 = math.random(-1,6) -- + 0-7 Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Kote +1*
    elseif npcUtil.tradeHasExactly(trade, {14822, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14822

        a1 = 145
        a2 = 31
        a3 = 53
        a4 = 515
        v1 = math.random(3)    -- + 1-4 Counter. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Evasion
        v3 = math.random(-1,4) -- + 0-5% Spell Interruption Rate Down
        v4 = math.random(-1,6) -- + 0-7 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Haidate +1*
    elseif npcUtil.tradeHasExactly(trade, {14304, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14304

        a1 = 146
        a2 = 39
        a3 = 142
        a4 = 515
        v1 = math.random(4)    -- + 1-5 Dual Weild. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Enmity
        v3 = math.random(-1,4) -- + 0-5 Store TP
        v4 = math.random(-1,5) -- + 0-6 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shura Sune-Ate +1*
    elseif npcUtil.tradeHasExactly(trade, {14185, 3282}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14185

        a1 = 194
        a2 = 143
        a3 = 512
        a4 = 515
        v1 = math.random(3)    -- + 1-4 Kick Attacks. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3 Double Attack
        v3 = math.random(-1,4) -- + 0-5 STR
        v4 = math.random(-1,4) -- + 0-5 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Adaman Celata*
    elseif npcUtil.tradeHasExactly(trade, {12429, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12429

        a1 = 293
        a2 = 141
        a3 = 52
        a4 = 35
        v1 = math.random(4,7)  -- + 5-8 Dark Magic Skill. Guaranteed.
        v2 = math.random(-1,7) -- + 0-8 Conserve MP
        v3 = math.random(-1,3) -- + 0-4 MP Recovered While Healing
        v4 = math.random(-1,2) -- + 0-3 Magic Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Adaman Hauberk*
    elseif npcUtil.tradeHasExactly(trade, {12557, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12557

        a1 = 143
        a2 = 142
        a3 = 195
        a4 = 1
        v1 = math.random(2)     -- + 1-3 Double Attack. Guaranteed.
        v2 = math.random(-1,5)  -- + 0-6 Store TP
        v3 = math.random(-1,4)  -- + 0-5 Subtle Blow
        v4 = math.random(-1,24) -- + 0-25 HP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Adaman Mufflers*
    elseif npcUtil.tradeHasExactly(trade, {12685, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12685

        a1 = 49
        a2 = 513
        a3 = 514
        a4 = 515
        v1 = math.random(2)    -- + 1-3% Haste. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 DEX
        v3 = math.random(-1,5) -- + 0-6 VIT
        v4 = math.random(-1,5) -- + 0-6 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Adaman Breeches*
    elseif npcUtil.tradeHasExactly(trade, {12813, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12813

        a1 = 512
        a2 = 333
        a3 = 40
        a4 = 516
        v1 = math.random(1,9)  -- + 2-10 STR. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Conserve TP
        v3 = math.random(-1,4) -- + 0-5 Enmity -
        v4 = math.random(-1,4) -- + 0-5 INT

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Adaman Sollerets*
    elseif npcUtil.tradeHasExactly(trade, {12941, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12941

        a1 = 111
        a2 = 324
        a3 = 99
        a4 = 116
        v1 = math.random(3)    -- + 1-4% Pet: Haste. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Call Beast Delay -
        v3 = math.random(-1,9) -- + 0-10 Pet: Defense
        v4 = math.random(-1,6) -- + 0-7 Pet: Subtle Blow

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Armada Celata*
    elseif npcUtil.tradeHasExactly(trade, {13924, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13924

        a1 = 293
        a2 = 141
        a3 = 52
        a4 = 35
        v1 = math.random(4,7)  -- + 5-8 Dark Magic Skill. Guaranteed.
        v2 = math.random(-1,7) -- + 0-8 Conserve MP
        v3 = math.random(-1,3) -- + 0-4 MP Recovered While Healing
        v4 = math.random(-1,2) -- + 0-3 Magic Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Armada Hauberk*
    elseif npcUtil.tradeHasExactly(trade, {14371, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14371

        a1 = 143
        a2 = 142
        a3 = 195
        a4 = 1
        v1 = math.random(2)     -- + 1-3 Double Attack. Guaranteed.
        v2 = math.random(-1,5)  -- + 0-6 Store TP
        v3 = math.random(-1,4)  -- + 0-5 Subtle Blow
        v4 = math.random(-1,24) -- + 0-25 HP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Armada Mufflers*
    elseif npcUtil.tradeHasExactly(trade, {14816, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14816

        a1 = 49
        a2 = 513
        a3 = 514
        a4 = 515
        v1 = math.random(2)    -- + 1-3% Haste. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 DEX
        v3 = math.random(-1,5) -- + 0-6 VIT
        v4 = math.random(-1,5) -- + 0-6 AGI

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Armada Breeches*
    elseif npcUtil.tradeHasExactly(trade, {14296, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14296

        a1 = 512
        a2 = 333
        a3 = 40
        a4 = 516
        v1 = math.random(1,9)  -- + 2-10 STR. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Conserve TP
        v3 = math.random(-1,4) -- + 0-5 Enmity -
        v4 = math.random(-1,4) -- + 0-5 INT

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Armada Sollerets*
    elseif npcUtil.tradeHasExactly(trade, {14175, 3281}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14175

        a1 = 111
        a2 = 324
        a3 = 99
        a4 = 116
        v1 = math.random(3)    -- + 1-4% Pet: Haste. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Call Beast Delay -
        v3 = math.random(-1,9) -- + 0-10 Pet: Defense
        v4 = math.random(-1,6) -- + 0-7 Pet: Subtle Blow

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Hat*
    elseif npcUtil.tradeHasExactly(trade, {16115, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 16115

        a1 = 101
        a2 = 297
        a3 = 292
        a4 = 290
        v1 = math.random(3)    -- + 1-4 Pet: Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4 String Instrument Skill
        v3 = math.random(-1,3) -- + 0-4 Elemental Magic Skill
        v4 = math.random(-1,3) -- + 0-4 Enhancing Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Coat*
    elseif npcUtil.tradeHasExactly(trade, {14575, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14575

        a1 = 35
        a2 = 516
        a3 = 517
        a4 = 518
        v1 = math.random(5)   -- + 1-6 Magic Accuracy. Guaranteed.
        v2 = math.random(1,9) -- + 0-10 INT
        v3 = math.random(1,9) -- + 0-10 MND
        v4 = math.random(1,9) -- + 0-10 CHR

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Cuffs*
    elseif npcUtil.tradeHasExactly(trade, {14997, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14997

        a1 = 133
        a2 = 141
        a3 = 53
        a4 = 9
        v1 = math.random(4)     -- + 1-5 Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,2)  -- + 0-3 Conserve MP
        v3 = math.random(-1,6)  -- + 0-7 Spell Interruption Rate Down
        v4 = math.random(-1,14) -- + 0-15 MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Trews*
    elseif npcUtil.tradeHasExactly(trade, {15657, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15657

        a1 = 133
        a2 = 97
        a3 = 102
        a4 = 320
        v1 = math.random(3)     -- + 1-4 Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,11) -- + 0-12 Pet: Attack/Ramged Attack
        v3 = math.random(-1,2)  -- + 0-3% Pet: Crit. Hit Rate
        v4 = math.random(-1,2)  -- + 0-3 Blood Pact Ability Delay -

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Clogs*
    elseif npcUtil.tradeHasExactly(trade, {15742, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15742

        a1 = 296
        a2 = 288
        a3 = 293
        a4 = 291
        v1 = math.random(4)    -- + 1-5 Singing Skill. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Divine Magic Skill
        v3 = math.random(-1,5) -- + 0-6 Dark Magic Skill
        v4 = math.random(-1,5) -- + 0-6 Enfeebling Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Hat*
    elseif npcUtil.tradeHasExactly(trade, {16116, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 16116

        a1 = 101
        a2 = 297
        a3 = 292
        a4 = 290
        v1 = math.random(3)    -- + 1-4 Pet: Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4 String Instrument Skill
        v3 = math.random(-1,3) -- + 0-4 Elemental Magic Skill
        v4 = math.random(-1,3) -- + 0-4 Enhancing Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Coat*
    elseif npcUtil.tradeHasExactly(trade, {14576, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14576

        a1 = 35
        a2 = 516
        a3 = 517
        a4 = 518
        v1 = math.random(5)   -- + 1-6 Magic Accuracy. Guaranteed.
        v2 = math.random(1,9) -- + 0-10 INT
        v3 = math.random(1,9) -- + 0-10 MND
        v4 = math.random(1,9) -- + 0-10 CHR

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Cuffs*
    elseif npcUtil.tradeHasExactly(trade, {14998, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14998

        a1 = 133
        a2 = 141
        a3 = 53
        a4 = 9
        v1 = math.random(4)     -- + 1-5 Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,2)  -- + 0-3 Conserve MP
        v3 = math.random(-1,6)  -- + 0-7 Spell Interruption Rate Down
        v4 = math.random(-1,14) -- + 0-15 MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Trews*
    elseif npcUtil.tradeHasExactly(trade, {15658, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15658

        a1 = 133
        a2 = 97
        a3 = 102
        a4 = 320
        v1 = math.random(3)     -- + 1-4 Magic Attack Bonus. Guaranteed.
        v2 = math.random(-1,11) -- + 0-12 Pet: Attack/Ramged Attack
        v3 = math.random(-1,2)  -- + 0-3% Pet: Crit. Hit Rate
        v4 = math.random(-1,2)  -- + 0-3 Blood Pact Ability Delay -

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Clogs*
    elseif npcUtil.tradeHasExactly(trade, {15743, 3286}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15743

        a1 = 296
        a2 = 288
        a3 = 293
        a4 = 291
        v1 = math.random(4)    -- + 1-5 Singing Skill. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Divine Magic Skill
        v3 = math.random(-1,5) -- + 0-6 Dark Magic Skill
        v4 = math.random(-1,5) -- + 0-6 Enfeebling Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Koenig Schaller*
    elseif npcUtil.tradeHasExactly(trade, {12421, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12421

        a1 = 140
        a2 = 42
        a3 = 153
        a4 = 329
        v1 = math.random(5)    -- + 1-6 Fast Cast. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Enemy Crit. Hit Rate -
        v3 = math.random(-1,2) -- + 0-3 Shield Mastery
        v4 = math.random(-1,5) -- + 0-6% Cure Potency

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Koenig Cuirass*
    elseif npcUtil.tradeHasExactly(trade, {12549, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12549

        a1 = 54
        a2 = 53
        a3 = 39
        a4 = 138
        v1 = math.random(5)    -- + 1-6% Physical Damage Taken -. Guaranteed.
        v2 = math.random(-1,7) -- + 0-8% Spell Interruption Rate -
        v3 = math.random(-1,6) -- + 0-7 Enmity
        v4 = math.random(-1,1) -- + 1-2 Refresh

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Koenig Handschuhs*
    elseif npcUtil.tradeHasExactly(trade, {12677, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12677

        a1 = 145
        a2 = 286
        a3 = 23
        a4 = 39
        v1 = math.random(2)    -- + 1-3 Counter. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Shield Skill
        v3 = math.random(-1,4) -- + 0-5 Accuracy
        v4 = math.random(-1,5) -- + 0-6 Enmity

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Koenig Diechlings*
    elseif npcUtil.tradeHasExactly(trade, {12805, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12805

        a1 = 55
        a2 = 9
        a3 = 288
        a4 = 289
        v1 = math.random(1,4)   -- + 2-5 Magic Damage Taken -. Guaranteed.
        v2 = math.random(-1,31) -- + 0-32 MP (BG Wiki Lists 35 but we cannot exceed 32 with this aug ID)
        v3 = math.random(-1,5)  -- + 0-6 Divine Magic Skill
        v4 = math.random(-1,4)  -- + 0-5 Healing Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Koenig Schuhs*
    elseif npcUtil.tradeHasExactly(trade, {12933, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 12933

        a1 = 137
        a2 = 49
        a3 = 23
        a4 = 25
        v1 = math.random(2)    -- + 1-3 Regen. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3% Haste
        v3 = math.random(-1,6) -- + 0-6 Accuracy
        v4 = math.random(-1,6) -- + 0-6 Attack

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kaiser Schaller*
    elseif npcUtil.tradeHasExactly(trade, {13911, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13911

        a1 = 140
        a2 = 42
        a3 = 153
        a4 = 329
        v1 = math.random(5)    -- + 1-6 Fast Cast. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Enemy Crit. Hit Rate -
        v3 = math.random(-1,2) -- + 0-3 Shield Mastery
        v4 = math.random(-1,5) -- + 0-6% Cure Potency

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kaiser Cuirass*
    elseif npcUtil.tradeHasExactly(trade, {14370, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14370

        a1 = 54
        a2 = 53
        a3 = 39
        a4 = 138
        v1 = math.random(5)    -- + 1-6% Physical Damage Taken -. Guaranteed.
        v2 = math.random(-1,7) -- + 0-8% Spell Interruption Rate -
        v3 = math.random(-1,6) -- + 0-7 Enmity
        v4 = math.random(-1,1) -- + 0-2 Refresh

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kaiser Handschuhs*
    elseif npcUtil.tradeHasExactly(trade, {14061, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14061

        a1 = 145
        a2 = 286
        a3 = 23
        a4 = 39
        v1 = math.random(2) -- + 1-3 Counter Guaranteed
        v2 = math.random(-1,4) -- + 0-5 Shield Skill
        v3 = math.random(-1,4) -- + 0-5 Accuracy
        v4 = math.random(-1,5) -- + 0-6 Enmity

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kaiser Diechlings*
    elseif npcUtil.tradeHasExactly(trade, {14283, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14283

        a1 = 55
        a2 = 9
        a3 = 288
        a4 = 289
        v1 = math.random(1,4)   -- + 2-5 Magic Damage Taken -. Guaranteed.
        v2 = math.random(-1,31) -- + 0-32 MP (BG Wiki Lists 35 but we cannot exceed 32 with this aug ID)
        v3 = math.random(-1,5)  -- + 0-6 Divine Magic Skill
        v4 = math.random(-1,4)  -- + 0-5 Healing Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Kaiser Schuhs*
    elseif npcUtil.tradeHasExactly(trade, {14163, 3280}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14163

        a1 = 137
        a2 = 49
        a3 = 23
        a4 = 25
        v1 = math.random(2)    -- + 1-3 Regen. Guaranteed.
        v2 = math.random(-1,2) -- + 0-3% Haste
        v3 = math.random(-1,6) -- + 0-6 Accuracy
        v4 = math.random(-1,6) -- + 0-6 Attack

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Cap*
    elseif npcUtil.tradeHasExactly(trade, {13927, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13927

        a1 = 143
        a2 = 25
        a3 = 514
        a4 = 516
        v1 = math.random(3)    -- + 1-4 Double Attack. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Attack
        v3 = math.random(-1,4) -- + 0-5 VIT
        v4 = math.random(-1,4) -- + 0-5 INT

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Harness*
    elseif npcUtil.tradeHasExactly(trade, {14378, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14378

        a1 = 513
        a2 = 142
        a3 = 333
        a4 = 25
        v1 = math.random(5)    -- + 1-6 DEX. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Store TP
        v3 = math.random(-1,4) -- + 0-5 Conserve TP
        v4 = math.random(-1,6) -- + 0-7 Attack

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Mittens*
    elseif npcUtil.tradeHasExactly(trade, {14076, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14076

        a1 = 145
        a2 = 258
        a3 = 259
        a4 = 261
        v1 = math.random(3)    -- + 1-4% Crit. Hit Damage. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4 Dagger Skill
        v3 = math.random(-1,3) -- + 0-4 Sword Skill
        v4 = math.random(-1,3) -- + 0-4 Axe Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Subligar*
    elseif npcUtil.tradeHasExactly(trade, {14308, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14308

        a1 = 41
        a2 = 23
        a3 = 195
        a4 = 31
        v1 = math.random(3)    -- + 1-4 Crit. Hit Rate. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 Accuracy
        v3 = math.random(-1,3) -- + 0-4 Subtle Blow
        v4 = math.random(-1,4) -- + 0-5 Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Leggings*
    elseif npcUtil.tradeHasExactly(trade, {14180, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14180

        a1 = 512
        a2 = 264
        a3 = 263
        a4 = 262
        v1 = math.random(3)    -- + 1-4 STR. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4 Polearm Skill
        v3 = math.random(-1,3) -- + 0-4 Scythe Skill
        v4 = math.random(-1,3) -- + 0-4 Great Axe Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Cap +1*
    elseif npcUtil.tradeHasExactly(trade, {13928, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13928

        a1 = 143
        a2 = 25
        a3 = 514
        a4 = 516
        v1 = math.random(3)    -- + 1-4 Double Attack. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Attack
        v3 = math.random(-1,4) -- + 0-5 VIT
        v4 = math.random(-1,4) -- + 0-5 INT

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Harness +1*
    elseif npcUtil.tradeHasExactly(trade, {14379, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14379

        a1 = 513
        a2 = 142
        a3 = 333
        a4 = 25
        v1 = math.random(5)    -- + 1-6 DEX. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Store TP
        v3 = math.random(-1,4) -- + 0-5 Conserve TP
        v4 = math.random(-1,6) -- + 0-7 Attack

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Mittens +1*
    elseif npcUtil.tradeHasExactly(trade, {14077, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14077

        a1 = 145
        a2 = 258
        a3 = 259
        a4 = 261
        v1 = math.random(3)    -- + 1-4% Crit. Hit Damage. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4 Dagger Skill
        v3 = math.random(-1,3) -- + 0-4 Sword Skill
        v4 = math.random(-1,3) -- + 0-4 Axe Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Subligar +1*
    elseif npcUtil.tradeHasExactly(trade, {14309, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14309

        a1 = 41
        a2 = 23
        a3 = 195
        a4 = 31
        v1 = math.random(3)    -- + 1-4 Crit. Hit Rate. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 Accuracy
        v3 = math.random(-1,3) -- + 0-4 Subtle Blow
        v4 = math.random(-1,4) -- + 0-5 Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Hecatomb Leggings +1*
    elseif npcUtil.tradeHasExactly(trade, {14181, 3279}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14181

        a1 = 512
        a2 = 264
        a3 = 263
        a4 = 262
        v1 = math.random(3)    -- + 1-4 STR. Guaranteed.
        v2 = math.random(-1,3) -- + 0-4 Polearm Skill
        v3 = math.random(-1,3) -- + 0-4 Scythe Skill
        v4 = math.random(-1,3) -- + 0-4 Great Axe Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Helm*
    elseif npcUtil.tradeHasExactly(trade, {16113, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 16113

        a1 = 138
        a2 = 134
        a3 = 55
        a4 = 9
        v1 = math.random(1)     -- + 1-2 Refresh. Guaranteed.
        v2 = math.random(-1,4)  -- + 0-5 Magic Defense Bonus
        v3 = math.random(-1,5)  -- + 0-6% Magic Damage Taken -
        v4 = math.random(-1,25) -- + 0-25 MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Breastplate*
    elseif npcUtil.tradeHasExactly(trade, {14573, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14573

        a1 = 144
        a2 = 23
        a3 = 134
        a4 = 37
        v1 = math.random(2)    -- + 1-3 Triple Attack. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Accuracy
        v3 = math.random(-1,4) -- + 0-5 Magic Defense Bonus
        v4 = math.random(-1,4) -- + 0-5 Magic Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Gauntlets*
    elseif npcUtil.tradeHasExactly(trade, {14995, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14995

        a1 = 143
        a2 = 512
        a3 = 262
        a4 = 263
        v1 = math.random(3)    -- + 1-4% Double Attack. Guaranteed.
        v2 = math.random(-1,7) -- + 0-8 STR
        v3 = math.random(-1,5) -- + 0-6 Great Axe Skill
        v4 = math.random(-1,5) -- + 0-6 Scythe Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Cuishes*
    elseif npcUtil.tradeHasExactly(trade, {15655, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15655

        a1 = 49
        a2 = 512
        a3 = 514
        a4 = 293
        v1 = math.random(2) -- + 1-3% Haste. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 STR
        v3 = math.random(-1,6) -- + 0-7 VIT
        v4 = math.random(-1,5) -- + 0-6 Dark Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Shadow Sabatons*
    elseif npcUtil.tradeHasExactly(trade, {15740, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15740

        a1 = 41
        a2 = 328
        a3 = 195
        a4 = 31
        v1 = math.random(2)    -- + 1-3% Crit. Hit Rate. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Crit. Hit Damage
        v3 = math.random(-1,3) -- + 0-4 Subtle Blow
        v4 = math.random(-1,1) -- + 0-2 Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Helm*
    elseif npcUtil.tradeHasExactly(trade, {16114, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 16114

        a1 = 138
        a2 = 134
        a3 = 55
        a4 = 9
        v1 = math.random(1)     -- + 1-2 Refresh. Guaranteed.
        v2 = math.random(-1,4)  -- + 0-5 Magic Defense Bonus
        v3 = math.random(-1,5)  -- + 0-6% Magic Damage Taken -
        v4 = math.random(-1,25) -- + 0-25 MP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Breastplate*
    elseif npcUtil.tradeHasExactly(trade, {14574, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14574

        a1 = 144
        a2 = 23
        a3 = 134
        a4 = 37
        v1 = math.random(2)    -- + 1-3 Triple Attack. Guaranteed.
        v2 = math.random(-1,9) -- + 0-10 Accuracy
        v3 = math.random(-1,4) -- + 0-5 Magic Defense Bonus
        v4 = math.random(-1,4) -- + 0-5 Magic Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Gauntlets*
    elseif npcUtil.tradeHasExactly(trade, {14996, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14996

        a1 = 143
        a2 = 512
        a3 = 262
        a4 = 263
        v1 = math.random(3)    -- + 1-4% Double Attack. Guaranteed.
        v2 = math.random(-1,7) -- + 0-8 STR
        v3 = math.random(-1,5) -- + 0-6 Great Axe Skill
        v4 = math.random(-1,5) -- + 0-6 Scythe Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Cuishes*
    elseif npcUtil.tradeHasExactly(trade, {15656, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15656

        a1 = 49
        a2 = 512
        a3 = 514
        a4 = 293
        v1 = math.random(2)    -- + 1-3% Haste. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 STR
        v3 = math.random(-1,6) -- + 0-7 VIT
        v4 = math.random(-1,5) -- + 0-6 Dark Magic Skill

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Valkyrie's Sabatons*
    elseif npcUtil.tradeHasExactly(trade, {15741, 3285}) and player:getFreeSlotsCount() >= 1 then
        itemId = 15741

        a1 = 41
        a2 = 328
        a3 = 195
        a4 = 31
        v1 = math.random(2)    -- + 1-3% Crit. Hit Rate. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Crit. Hit Damage
        v3 = math.random(-1,3) -- + 0-4 Subtle Blow
        v4 = math.random(-1,1) -- + 0-2 Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Crimson Mask*
    elseif npcUtil.tradeHasExactly(trade, {13908, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13908

        a1 = 35
        a2 = 27
        a3 = 515
        a4 = 325
        v1 = math.random(4)    -- + 1-5 Magic Accuracy. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Ranged Accuracy
        v3 = math.random(-1,5) -- + 0-6 AGI
        v4 = math.random(-1,4) -- + 0-5 Quick Draw Ability Delay -

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Crimson Scale Mail*
    elseif npcUtil.tradeHasExactly(trade, {14367, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14367

        a1 = 49
        a2 = 512
        a3 = 515
        a4 = 23
        v1 = math.random(2)    -- + 1-3 Haste. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 STR
        v3 = math.random(-1,6) -- + 0-7 AGI
        v4 = math.random(-1,9) -- + 0-10 Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Crimson Finger Gauntlets*
    elseif npcUtil.tradeHasExactly(trade, {14058, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14058

        a1 = 211
        a2 = 282
        a3 = 195
        a4 = 40
        v1 = math.random(3)    -- + 1-4 Snapshot. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Marksmanship Skill
        v3 = math.random(-1,5) -- + 0-6 Subtle Blow
        v4 = math.random(-1,4) -- + 0-5 Enmity -

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Crimson Cuisses*
    elseif npcUtil.tradeHasExactly(trade, {14280, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14280

        a1 = 140
        a2 = 31
        a3 = 134
        a4 = 37
        v1 = math.random(4)    -- + 1-5 Fast Cast. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 Evasion
        v3 = math.random(-1,6) -- + 0-7 Magic Defense Bonus
        v4 = math.random(-1,6) -- + 0-7 Magic Evasion

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Crimson Greaves*
    elseif npcUtil.tradeHasExactly(trade, {14160, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14160

        a1 = 299
        a2 = 23
        a3 = 332
        a4 = 142
        v1 = math.random(4)    -- + 1-5 Blue Magic Skill. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Accuracy
        v3 = math.random(-1,2) -- + 0-3% Skillchain Damage
        v4 = math.random(-1,4) -- + 0-5 Store TP

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Blood Mask*
    elseif npcUtil.tradeHasExactly(trade, {13909, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 13909

        a1 = 35
        a2 = 27
        a3 = 515
        a4 = 325
        v1 = math.random(4)    -- + 1-5 Magic Accuracy. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Ranged Accuracy
        v3 = math.random(-1,5) -- + 0-6 AGI
        v4 = math.random(-1,4) -- + 0-5 Quick Draw Ability Delay

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Blood Scale Mail*
    elseif npcUtil.tradeHasExactly(trade, {14368, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14368

        a1 = 49
        a2 = 512
        a3 = 515
        a4 = 23
        v1 = math.random(2)    -- + 1-3 Haste. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 STR
        v3 = math.random(-1,6) -- + 0-7 AGI
        v4 = math.random(-1,9) -- + 0-10 Accuracy

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Blood Finger Gauntlets*
    elseif npcUtil.tradeHasExactly(trade, {14059, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14059

        a1 = 211
        a2 = 282
        a3 = 195
        a4 = 40
        v1 = math.random(3)    -- + 1-4 Snapshot. Guaranteed.
        v2 = math.random(-1,5) -- + 0-6 Marksmanship Skill
        v3 = math.random(-1,5) -- + 0-6 Subtle Blow
        v4 = math.random(-1,4) -- + 0-5 Enmity -

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Blood Cuisses*
    elseif npcUtil.tradeHasExactly(trade, {14281, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14281

        a1 = 140
        a2 = 31
        a3 = 134
        a4 = 37
        v1 = math.random(4)    -- + 1-5 Fast Cast. Guaranteed.
        v2 = math.random(-1,6) -- + 0-7 Evasion.
        v3 = math.random(-1,6) -- + 0-7 Magic Defense Bonus.
        v4 = math.random(-1,6) -- + 0-7 Magic Evasion.

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- *Blood Greaves*
    elseif npcUtil.tradeHasExactly(trade, {14161, 3284}) and player:getFreeSlotsCount() >= 1 then
        itemId = 14161

        a1 = 299
        a2 = 23
        a3 = 332
        a4 = 142
        v1 = math.random(4)    -- + 1-5 Blue Magic Skill. Guaranteed.
        v2 = math.random(-1,4) -- + 0-5 Accuracy.
        v3 = math.random(-1,2) -- + 0-3% Skillchain Damage.
        v4 = math.random(-1,4) -- + 0-5 Store TP.

        handleAugmentedItemCreation(player,itemId,a1,a2,a3,a4,v1,v2,v3,v4)

    -- Fallback.
    else
        player:PrintToPlayer( "This item combination is incorrect or not enough inventory space available.", 0xd )
    end
end

entity.onTrigger = function(player, npc)
    player:PrintToPlayer( "You feel if you trade some items, something would happen.", 0xd )
end

return entity
