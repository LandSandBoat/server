-----------------------------------
-- Provenance Protocrystal
-----------------------------------
---@type TNpcEntity

local augments =
{
    [xi.item.PRISM_CAPE] =
    {
        slots =
        {
            {
                -- 1/4 chance for +1-3% fast cast
                { weight = 1, id = xi.augment.FAST_CAST_P1, minValue = 0, maxValue = 2 },
                -- 1/4 chance for +1-4 magic accuracy
                { weight = 1, id = xi.augment.MAG_ACC_P1, minValue = 0, maxValue = 3 },
                -- 1/4 chance for +1-4% cure potency
                { weight = 1, id = xi.augment.CURE_POTENCY_P1, minValue = 0, maxValue = 3 },
                -- 1/4 chance for +10-20% spell interruption rate down
                { weight = 1, id = xi.augment.SPELL_INTERRUPTION_RATE_DOWN_P1, minValue = 9, maxValue = 19 },
            },
        }
    },
    [xi.item.HAUBERGEON_P1] =
    {
        slots =
        {
            {
                -- 1/9 change of +3-8 sword skill
                { weight = 1, id = xi.augment.SWORD_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 great sword skill
                { weight = 1, id = xi.augment.GREAT_SWORD_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 axe skill
                { weight = 1, id = xi.augment.AXE_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 great axe skill
                { weight = 1, id = xi.augment.GREAT_AXE_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 scythe skill
                { weight = 1, id = xi.augment.SCYTHE_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 polearm skill
                { weight = 1, id = xi.augment.POLEARM_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 katana skill
                { weight = 1, id = xi.augment.KATANA_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 great katana skill
                { weight = 1, id = xi.augment.GREAT_KATANA_SKILL_P1, minValue = 2, maxValue = 7 },
                -- 1/9 change of +3-8 club skill
                { weight = 1, id = xi.augment.CLUB_SKILL_P1, minValue = 2, maxValue = 7 },
            },
            {
                -- +1-32 DEF
                { weight = 1, id = xi.augment.DEF_P1, minValue = 0, maxValue = 31 },
            }
        }
    },
    [xi.item.TOREADORS_RING] =
    {
        slots =
        {
            {
                -- 1/21 chance for +1-2% crit rate
                { weight = 56, id = xi.augment.CRITICAL_HIT_RATE_P1, minValue = 0, maxValue = 1 },
                -- 1/21 chance for +1-5% crit damage
                { weight = 56, id = xi.augment.CRITICAL_HIT_DAMAGE_P1, minValue = 0, maxValue = 4 },
                -- 1/21 chance for +1-3% crit rate
                { weight = 56, id = xi.augment.CRITICAL_HIT_RATE_P1, minValue = 0, maxValue = 2 },
                -- 1/21 chance for +1-7 ranged attack
                { weight = 56, id = xi.augment.RNG_ATK_P1, minValue = 0, maxValue = 6 },
                -- 1/21 chance for +1-13 ranged accuracy
                { weight = 56, id = xi.augment.RNG_ACC_P1, minValue = 0, maxValue = 12 },
                -- 1/21 chance for +1-2% triple attack
                { weight = 56, id = xi.augment.TRIPLE_ATTACK_P1, minValue = 0, maxValue = 1 },
                -- 1/21 chance for +1-5 enmity
                { weight = 56, id = xi.augment.ENMITY_P1, minValue = 0, maxValue = 4 },
                -- 1/21 chance for -1-5 enmity
                { weight = 56, id = xi.augment.ENMITY_M1, minValue = 0, maxValue = 4 },
                -- 2/21 chance for +1-5 accuracy
                { weight = 112, id = xi.augment.ACCURACY_P1, minValue = 0, maxValue = 4 },
                -- 2/21 chance for +1-5 attack
                { weight = 112, id = xi.augment.ATTACK_P1, minValue = 0, maxValue = 4 },
                -- 3/21 chance for +1-3 to one of seven attributes
                { weight = 24, id = xi.augment.STR_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.DEX_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.VIT_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.AGI_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.INT_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.MND_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.CHR_P1, minValue = 0, maxValue = 2 },
                -- 6/21 chance for +1-12 to one of eight elemental resistances
                { weight = 42, id = xi.augment.FIRE_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 42, id = xi.augment.ICE_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 42, id = xi.augment.WIND_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 42, id = xi.augment.EARTH_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 42, id = xi.augment.LIGHTNING_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 42, id = xi.augment.WATER_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 42, id = xi.augment.LIGHT_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 42, id = xi.augment.DARK_RESIST_P1, minValue = 0, maxValue = 11 },
            },
            {
                -- 1/21 chance for +1-5% crit damage
                { weight = 56, id = xi.augment.CRITICAL_HIT_DAMAGE_P1, minValue = 0, maxValue = 4 },
                -- 1/21 chance for +1-3% crit rate
                { weight = 56, id = xi.augment.CRITICAL_HIT_RATE_P1, minValue = 0, maxValue = 2 },
                -- 1/21 chance for +1-7 ranged attack
                { weight = 56, id = xi.augment.RNG_ATK_P1, minValue = 0, maxValue = 6 },
                -- 1/21 chance for +1-13 ranged accuracy
                { weight = 56, id = xi.augment.RNG_ACC_P1, minValue = 0, maxValue = 12 },
                -- 1/21 chance for +1-2% triple attack
                { weight = 56, id = xi.augment.TRIPLE_ATTACK_P1, minValue = 0, maxValue = 1 },
                -- 1/21 chance for +1-5 enmity
                { weight = 56, id = xi.augment.ENMITY_P1, minValue = 0, maxValue = 4 },
                -- 1/21 chance for -1-5 enmity
                { weight = 56, id = xi.augment.ENMITY_M1, minValue = 0, maxValue = 4 },
                -- 2/21 chance for +1-5 accuracy
                { weight = 112, id = xi.augment.ACCURACY_P1, minValue = 0, maxValue = 4 },
                -- 2/21 chance for +1-5 attack
                { weight = 112, id = xi.augment.ATTACK_P1, minValue = 0, maxValue = 4 },
                -- 3/21 chance for +1-3 to one of seven attributes
                { weight = 24, id = xi.augment.STR_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.DEX_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.VIT_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.AGI_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.INT_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.MND_P1, minValue = 0, maxValue = 2 },
                { weight = 24, id = xi.augment.CHR_P1, minValue = 0, maxValue = 2 },
                -- 7/21 chance for +1-12 to one of eight elemental resistances
                { weight = 49, id = xi.augment.FIRE_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 49, id = xi.augment.ICE_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 49, id = xi.augment.WIND_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 49, id = xi.augment.EARTH_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 49, id = xi.augment.LIGHTNING_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 49, id = xi.augment.WATER_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 49, id = xi.augment.LIGHT_RESIST_P1, minValue = 0, maxValue = 11 },
                { weight = 49, id = xi.augment.DARK_RESIST_P1, minValue = 0, maxValue = 11 },
            },
        }
    },
    [xi.item.LOQUACIOUS_EARRING] =
    {
        slots =
        {
            {
                -- 1/4 chance for +33-53 MP
                { weight = 1, id = xi.augment.MP_P33, minValue = 0, maxValue = 20 },
                -- 1/4 chance for +5-10 conserve MP
                { weight = 1, id = xi.augment.CONSERVE_MP_P1, minValue = 4, maxValue = 9 },
                -- 1/4 chance for +1-5 magic accuracy
                { weight = 1, id = xi.augment.MAG_ACC_P1, minValue = 0, maxValue = 4 },
                -- 1/4 chance for +3-13 dark magic skill
                { weight = 1, id = xi.augment.DARK_MAGIC_SKILL_P1, minValue = 2, maxValue = 12 },
            },
        }
    },
    [xi.item.BRUTAL_EARRING] =
    {
        slots =
        {
            {
                -- 1/4 chance for +1-3% double attack
                { weight = 1, id = xi.augment.DOUBLE_ATTACK_P1, minValue = 0, maxValue = 2 },
                -- 2/4 chance for +1-3 dual wield
                { weight = 2, id = xi.augment.DUAL_WIELD_P1, minValue = 0, maxValue = 2 },
                -- 1/4 chance for +1% haste
                { weight = 1, id = xi.augment.HASTE_P1, minValue = 0, maxValue = 0 },
            },
            {
                -- 1/4 chance for +1-3% double attack
                { weight = 1, id = xi.augment.DOUBLE_ATTACK_P1, minValue = 0, maxValue = 2 },
                -- 1/4 chance for +1-3 dual wield
                { weight = 1, id = xi.augment.DUAL_WIELD_P1, minValue = 0, maxValue = 2 },
                -- 2/4 chance for +1% haste
                { weight = 2, id = xi.augment.HASTE_P1, minValue = 0, maxValue = 0 },
            },
        }
    },
    [xi.item.WALAHRA_TURBAN] =
    {
        slots =
        {
            {
                -- 1/4 chance for +3-10 store TP
                { weight = 1, id = xi.augment.STORE_TP_P1, minValue = 2, maxValue = 9 },
                -- 1/4 chance for +1% haste
                { weight = 1, id = xi.augment.HASTE_P1, minValue = 0, maxValue = 0 },
                -- 1/4 chance for +8-10 evasion
                { weight = 1, id = xi.augment.EVASION_P1, minValue = 7, maxValue = 9 },
                -- 1/4 chance for +3-10 enhancing magic skill
                { weight = 1, id = xi.augment.ENHANCING_MAGIC_SKILL_P1, minValue = 2, maxValue = 9 },
            },
        }
    },
    [xi.item.VELOCIOUS_BELT] =
    {
        slots =
        {
            {
                -- +1-3 to one of seven attributes
                { weight = 1, id = xi.augment.STR_P1, minValue = 0, maxValue = 2 },
                { weight = 1, id = xi.augment.DEX_P1, minValue = 0, maxValue = 2 },
                { weight = 1, id = xi.augment.VIT_P1, minValue = 0, maxValue = 2 },
                { weight = 1, id = xi.augment.AGI_P1, minValue = 0, maxValue = 2 },
                { weight = 1, id = xi.augment.INT_P1, minValue = 0, maxValue = 2 },
                { weight = 1, id = xi.augment.MND_P1, minValue = 0, maxValue = 2 },
                { weight = 1, id = xi.augment.CHR_P1, minValue = 0, maxValue = 2 },
            },
            {
                -- +10-30 to one of eight elemental resistances
                { weight = 1, id = xi.augment.FIRE_RESIST_P1, minValue = 9, maxValue = 29 },
                { weight = 1, id = xi.augment.ICE_RESIST_P1, minValue = 9, maxValue = 29 },
                { weight = 1, id = xi.augment.WIND_RESIST_P1, minValue = 9, maxValue = 29 },
                { weight = 1, id = xi.augment.EARTH_RESIST_P1, minValue = 9, maxValue = 29 },
                { weight = 1, id = xi.augment.LIGHTNING_RESIST_P1, minValue = 9, maxValue = 29 },
                { weight = 1, id = xi.augment.WATER_RESIST_P1, minValue = 9, maxValue = 29 },
                { weight = 1, id = xi.augment.LIGHT_RESIST_P1, minValue = 9, maxValue = 29 },
                { weight = 1, id = xi.augment.DARK_RESIST_P1, minValue = 9, maxValue = 29 },
            },
            {
                -- +20 to one of eight elemental resistances (same type as slot 2)
                -- This is done to sidestep +32 max value for an augment
                -- Results in total +30-50 to one of eight elemental resistances
                { weight = 1, mirrorSlotID = 2, minValue = 19, maxValue = 19 },
            }
        }
    },
    [xi.item.BIBIKI_SEASHELL] =
    {
        slots =
        {
            {
                -- +1-5 HP recovered while healing
                { weight = 1, id = xi.augment.HP_RECOVERED_WHILE_HEALING_P1, minValue = 0, maxValue = 4 },
            },
            {
                -- +1-5 MP recovered while healing, always same value as the first slot
                { weight = 1, id = xi.augment.MP_RECOVERED_WHILE_HEALING_P1, mirrorSlotValue = 1 },
            },
            {
                -- 1/4 chance for +1-3% spell interruption rate down
                { weight = 1, id = xi.augment.SPELL_INTERRUPTION_RATE_DOWN_P1, minValue = 0, maxValue = 2 },
                -- 1/4 chance for -1-3% physical damage taken
                { weight = 1, id = xi.augment.PHYS_DMG_TAKEN_M1, minValue = 0, maxValue = 2 },
                -- 1/4 chance for -1-3% magic damage taken
                { weight = 1, id = xi.augment.MAGIC_DMG_TAKEN_M1, minValue = 0, maxValue = 2 },
                -- 1/4 chance for -1-3% breath damage taken
                { weight = 1, id = xi.augment.BREATH_DMG_TAKEN_M1, minValue = 0, maxValue = 2 },
            },
        }
    },
    [xi.item.ROSE_STRAP] =
    {
        slots =
        {
            {
                -- 1/11 chance for +2-4 store tp and subtle blow
                { weight = 1, id = xi.augment.STORE_TP_P1_SUBTLE_BLOW_P1, minValue = 1, maxValue = 3 },
                -- 1/11 chance for +2-7 accuracy
                { weight = 1, id = xi.augment.ACCURACY_P1, minValue = 1, maxValue = 6 },
                -- 1/11 chance for +1 zanshin
                { weight = 1, id = xi.augment.ZANSHIN_P1, minValue = 0, maxValue = 0 },
                -- 1/11 chance for +2-4 great sword skill
                { weight = 1, id = xi.augment.GREAT_SWORD_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/11 chance for +2-4 great axe skill
                { weight = 1, id = xi.augment.GREAT_AXE_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/11 chance for +2-4 scythe skill
                { weight = 1, id = xi.augment.SCYTHE_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/11 chance for +2-4 polearm skill
                { weight = 1, id = xi.augment.POLEARM_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/11 chance for +2-4 great katana skill
                { weight = 1, id = xi.augment.GREAT_KATANA_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/11 chance for +2-4 staff skill
                { weight = 1, id = xi.augment.STAFF_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/11 chance for +4-10 resist blind
                { weight = 1, id = xi.augment.RESIST_BLIND_P1, minValue = 3, maxValue = 9 },
                -- 1/11 chance for +4-10 resist paralyze
                { weight = 1, id = xi.augment.RESIST_PARALYZE_P1, minValue = 3, maxValue = 9 },
            },
            {
                -- 1/8 chance for +2-4 great sword skill
                { weight = 1, id = xi.augment.GREAT_SWORD_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/8 chance for +2-4 great axe skill
                { weight = 1, id = xi.augment.GREAT_AXE_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/8 chance for +2-4 scythe skill
                { weight = 1, id = xi.augment.SCYTHE_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/8 chance for +2-4 polearm skill
                { weight = 1, id = xi.augment.POLEARM_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/8 chance for +2-4 great katana skill
                { weight = 1, id = xi.augment.GREAT_KATANA_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/8 chance for +2-4 staff skill
                { weight = 1, id = xi.augment.STAFF_SKILL_P1, minValue = 1, maxValue = 3 },
                -- 1/8 chance for +4-10 resist blind
                { weight = 1, id = xi.augment.RESIST_BLIND_P1, minValue = 3, maxValue = 9 },
                -- 1/8 chance for +4-10 resist paralyze
                { weight = 1, id = xi.augment.RESIST_PARALYZE_P1, minValue = 3, maxValue = 9 },
            },
        }
    },
}

local function getMeritExchangeValue(player)
    local exchangeValue = 250

    -- if CRUORBOOST == 1 or CRUORBOOST >= os.time() then
    --     exchangeValue = exchangeValue * 2
    -- end

    if player:getVar("MentorFlag") == 1 then
        exchangeValue = exchangeValue * 4
    end

    return exchangeValue
end

local function getPurchaseRefractiveFunc(quantity, name)
    return function(player)
        player:queue(0, function(player)
            local cost = quantity * 1000

            local confirmationMenu =
            {
                title = "Confirm Purchase (pay " .. cost .. " cruor)",
                options =
                {
                    { "Purchase " .. name .. ".", function(player)
                        local cruor       = player:getCurrency("cruor")
                        local neededSlots = math.ceil(quantity / 12)

                        if cruor < cost then
                            player:printToPlayer(string.format("You do not have enough cruor. It costs %i cruor but you possess %i.", cost, cruor))
                            return
                        end

                        if player:getFreeSlotsCount() < neededSlots then
                            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.REFRACTIVE_CRYSTAL)
                            return
                        end

                        player:delCurrency("cruor", cost)

                        local remainingQuantity = quantity

                        while remainingQuantity > 0 do
                            npcUtil.giveItem(player, {{ xi.item.REFRACTIVE_CRYSTAL, math.min(12, remainingQuantity) }})
                            remainingQuantity = remainingQuantity - 12
                        end
                    end },
                    { "I changed my mind.", function(player) return end },
                }
            }

            player:customMenu(confirmationMenu)
        end)
    end
end

local function getMeritExchangeFunc(quantity, name)
    return function(player)
        player:queue(0, function(player)
            local cruor = getMeritExchangeValue(player) * quantity
            local confirmationMenu =
            {
                title = "Confirm Purchase (pay " .. name .. ")",
                options =
                {
                    { "Purchase " .. cruor .. " cruor.", function(player)
                        local merits = player:getMeritCount()

                        if merits < quantity then
                            player:printToPlayer(string.format("You do not have enough merits. It costs %i merits but you possess %i merits.", quantity, merits))
                            return
                        end

                        player:addCurrency("cruor", cruor)
                        player:setMerits(merits - quantity)

                        player:printToPlayer(string.format("Awarded %i Cruor. New Total: %i", cruor, player:getCurrency("cruor")), xi.msg.channel.SAY, "Protocrystal")
                    end },
                    { "I changed my mind.", function(player) return end },
                }
            }

            player:customMenu(confirmationMenu)
        end)
    end
end

local protocrystalMenus

local function getOpenMenuFunc(menuName)
    return function(player)
        player:queue(0, function(player)
            local menu = protocrystalMenus[menuName]

            if menuName == "Merit Exchange" then
                menu = {title = menu.title, options = menu.options}
                menu.title = string.format(menu.title, getMeritExchangeValue(player))
            end

            player:customMenu(menu)
        end)
    end
end

protocrystalMenus =
{
    ["Main Menu"] =
    {
        title = "Choose a category.",
        options =
        {
            { "Refractive Crystals", getOpenMenuFunc("Refractive Crystals") },
            { "Merit Exchange",      getOpenMenuFunc("Merit Exchange") },
            { "Exit", function(player) return end },
        }
    },
    ["Refractive Crystals"] =
    {
        title = "Each refractive crystal costs 1000 cruor.",
        options =
        {
            { "1x Refractive Crystal",   getPurchaseRefractiveFunc( 1, "1x Refractive Crystal") },
            { "5x Refractive Crystals",  getPurchaseRefractiveFunc( 5, "5x Refractive Crystals") },
            { "10x Refractive Crystals", getPurchaseRefractiveFunc(10, "10x Refractive Crystals") },
            { "50x Refractive Crystals", getPurchaseRefractiveFunc(50, "50x Refractive Crystals") },
            { "Back", getOpenMenuFunc("Main Menu") },
        }
    },
    ["Merit Exchange"] =
    {
        title = "Each merit paid gives %i cruor.",
        options =
        {
            { "Pay 1x Merit",   getMeritExchangeFunc( 1, "1x Merit") },
            { "Pay 5x Merits",  getMeritExchangeFunc( 5, "5x Merits") },
            { "Pay 10x Merits", getMeritExchangeFunc(10, "10x Merits") },
            { "Pay 25x Merits", getMeritExchangeFunc(25, "25x Merits") },
            { "Back", getOpenMenuFunc("Main Menu") },
        }
    },
}

local entity = {}

entity.onTrigger = function(player, npc)
	local cruor = player:getCurrency("cruor")
    local merit = player:getMeritCount()

    local debounce = player:getLocalVar("ThrottleTime")

    if debounce < os.time() then
        player:setLocalVar("ThrottleTime", os.time() + 30)

        player:printToPlayer("Use cruor to augment a variety of items!", xi.msg.channel.SAY, "Protocrystal")
        player:printToPlayer("Visit https://ffera.fandom.com/wiki/Augments for more details.", xi.msg.channel.SAY, "Protocrystal")
        player:printToPlayer("Exchange cruor with Refractive Crystals at a rate of 1000-to-1.", xi.msg.channel.SAY, "Protocrystal")
        player:printToPlayer(string.format("Gain cruor by paying merits at a rate of %i-to-1.", getMeritExchangeValue(player)), xi.msg.channel.SAY, "Protocrystal")

        -- if CRUORBOOST == 1 or CRUORBOOST >= os.time() then
        --     player:printToPlayer("Double Cruor From Merits Event Active!", xi.msg.channel.SAY, "Protocrystal")
        -- end

        player:printToPlayer(string.format("You currently have %d Cruor and %i available Merits", cruor, merit), xi.msg.channel.SAY, "Protocrystal")
    end

    player:customMenu(protocrystalMenus["Main Menu"])
end

entity.onTrade = function(player, npc, trade)
    local cruor = player:getCurrency("cruor")
    local refractiveCrystals = trade:getItemQty(xi.item.REFRACTIVE_CRYSTAL)

    -- Trade Refractive Crystals for Cruor
    if npcUtil.tradeHasExactly(trade, {{xi.item.REFRACTIVE_CRYSTAL, refractiveCrystals}}) then
        player:confirmTrade()
        player:addCurrency("cruor", refractiveCrystals * 1000)
        player:printToPlayer(string.format("Awarded %i Cruor. New total: %i.", refractiveCrystals * 1000, refractiveCrystals * 1000 + cruor), xi.msg.channel.SAY, "Protocrystal")
        return
    end

    if cruor < 1000 then
        player:printToPlayer("Insufficient cruor.", xi.msg.channel.SAY, "Protocrystal")
        return
    end

    local rings =
    {
        xi.item.NOVENNNIAL_RING, xi.item.ALLIED_RING, xi.item.CHARIOT_BAND, xi.item.EMPRESS_BAND, xi.item.EMPEROR_BAND, xi.item.ANNIVERSARY_RING, xi.item.KUPOFRIEDS_RING,
    }

    -- ring trades
    for _, k in pairs(rings) do
        if npcUtil.tradeHasExactly(trade, k) then
            player:confirmTrade()
            player:delCurrency("cruor", 1000)
            npcUtil.giveItem(player, k)
            break
        end
    end

    for itemID, entry in pairs(augments) do
        if npcUtil.tradeHasExactly(trade, itemID) then
            player:confirmTrade()
            player:delCurrency("cruor", 1000)

            local slots = {}

            for index, slot in ipairs(entry.slots) do
                local totalWeight = 0

                for _, slotEntry in ipairs(slot) do
                    totalWeight = totalWeight + slotEntry.weight
                end

                local roll = math.random(1, totalWeight)

                for _, slotEntry in ipairs(slot) do
                    if roll <= slotEntry.weight then
                        slots[index] = { id = slotEntry.id }

                        if slotEntry.mirrorSlotID then
                            slots[index].id = slots[slotEntry.mirrorSlotID].id
                        end

                        if slotEntry.mirrorSlotValue then
                            slots[index].value = slots[slotEntry.mirrorSlotValue].value
                        elseif slotEntry.maxValue > slotEntry.minValue then
                            slots[index].value = math.random(slotEntry.minValue, slotEntry.maxValue)
                        else
                            slots[index].value = slotEntry.maxValue
                        end

                        break
                    end

                    roll = roll - slotEntry.weight
                end
            end

            if #slots == 1 then
                player:addItem(itemID, 1, slots[1].id, slots[1].value)
            elseif #slots == 2 then
                player:addItem(itemID, 1, slots[1].id, slots[1].value, slots[2].id, slots[2].value)
            elseif #slots == 3 then
                player:addItem(itemID, 1, slots[1].id, slots[1].value, slots[2].id, slots[2].value, slots[3].id, slots[3].value)
            elseif #slots == 4 then
                player:addItem(itemID, 1, slots[1].id, slots[1].value, slots[2].id, slots[2].value, slots[3].id, slots[3].value, slots[4].id, slots[4].value)
            else
                player:addItem(itemID, 1)
            end

            player:messageSpecial(ID.text.ITEM_OBTAINED, itemID)
            break
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
