-----------------------------------
-- Monstrosity - Teyrnon (Feretory)
-- Sells families, variants, instincts and buffs for infamy.
-----------------------------------
require('scripts/globals/monstrosity/species')
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

-- Each shop page has its own message, which names the slot.
local pageMessages =
{
    [0] = 'MAY_POSSESS_BEASTS',
    [1] = 'MAY_POSSESS_PLANTOIDS',
    [2] = 'MAY_POSSESS_VERMIN',
    [3] = 'MAY_POSSESS_LIZARDS',
    [4] = 'MAY_POSSESS_AMORPHS',
    [5] = 'MAY_POSSESS_AQUANS',
    [6] = 'MAY_POSSESS_BIRDS',
}

-- The shop lives in data/monstrosity.yaml and does not change once loaded.
local teyrnonShop

local function getTeyrnonShop(player)
    teyrnonShop = teyrnonShop or player:getMonstrosityShop()

    return teyrnonShop
end

local function tryPayInfamy(player, cost)
    if player:getCurrency('infamy') < cost then
        player:messageSpecial(zones[xi.zone.FERETORY].text.THY_BRAZEN_DISREGARD)
        return false
    end

    player:delCurrency('infamy', cost)
    return true
end

local function hasCompletedLimitBreak(player, jobId)
    if jobId <= xi.job.SMN then
        return utils.mask.getBit(player:getCharVar('maatsCap'), jobId - 1)
    end

    return player:hasCompletedQuest(unpack(xi.monstrosity.limitBreakQuests[jobId]))
end

local function getLimitBreakMask(player)
    local limitMask = 0
    for jobId = xi.job.WAR, xi.job.RUN do
        if hasCompletedLimitBreak(player, jobId) then
            limitMask = utils.mask.setBit(limitMask, jobId, true)
        end
    end

    return limitMask
end

-- A slot is for sale while its species or variant is still locked and its unlisted requirements are met.
-- Takes the Monstrosity data rather than the player, as building it is costly and clients can spam updates.
local function canBuy(data, entry)
    local locked =
        (entry.monSpecies and data.levels[entry.monSpecies] == 0) or
        (entry.monVariant and not xi.monstrosity.hasVariantBit(data, entry.monVariant))

    if not locked then
        return false
    end

    for _, requirement in ipairs(entry.requirements or {}) do
        if data.levels[requirement[1]] < requirement[2] then
            return false
        end
    end

    return true
end

local function getPageMask(player, page)
    local data     = player:getMonstrosityData()
    local pageMask = 0
    for slot, entry in pairs(getTeyrnonShop(player)[page] or {}) do
        if canBuy(data, entry) then
            pageMask = utils.mask.setBit(pageMask, slot, true)
        end
    end

    return pageMask
end

local function castBuff(player, buff)
    player:delStatusEffectSilent(buff.effect)

    if buff.expCap then
        xi.itemUtils.addItemExpEffect(player, buff.effect, buff.power, buff.duration, buff.expCap)
        return
    end

    local power = buff.power
    local tier  = nil
    if buff.tiers then
        local level = player:getMainLvl()
        for idx, row in ipairs(buff.tiers) do
            if level < row.level then
                tier  = idx
                power = row.power
                break
            end
        end

        if player:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
            power = power + buff.tierBonus * tier
        end
    end

    player:addStatusEffect(buff.effect, { power = power, duration = buff.duration, origin = player, tick = buff.tick, tier = tier })
end

local function buyMonster(player, option)
    local page  = bit.band(bit.rshift(option, 8), 0xF) - 1
    local slot  = bit.rshift(option, 16)
    local entry = (getTeyrnonShop(player)[page] or {})[slot]
    if
        not entry or
        not canBuy(player:getMonstrosityData(), entry)
    then
        print(string.format('Invalid Event Finish Option received by Teyrnon! (%s:%d)', player:getName(), option))
        return
    end

    if not tryPayInfamy(player, entry.infamyCost) then
        return
    end

    if entry.monSpecies then
        xi.monstrosity.unlockSpecies(player, entry.monSpecies)
    else
        xi.monstrosity.unlockVariant(player, entry.monVariant)
    end

    player:messageSpecial(zones[xi.zone.FERETORY].text[pageMessages[page]], page + 1, slot)
end

-- The client sends 119 in bits 16 and up with every instinct purchase.
local function buyInstinct(player, option)
    local instinct = bit.band(bit.rshift(option, 8), 0xFF)
    if
        bit.rshift(option, 16) ~= 119 or
        instinct < xi.monstrosityInstinct.HUME_II or
        instinct > xi.monstrosityInstinct.RUN or
        bit.band(xi.monstrosity.getPurchasedInstinctBits(player), bit.lshift(1, instinct)) ~= 0
    then
        print(string.format('Invalid Event Finish Option received by Teyrnon! (%s:%d)', player:getName(), option))
        return
    end

    local prices = xi.monstrosity.instinctPrices
    local price  = prices.race
    if instinct > xi.monstrosityInstinct.GALKA_II then
        price = prices.job
        if hasCompletedLimitBreak(player, instinct - xi.monstrosityInstinct.GALKA_II) then
            price = prices.limitBroken
        end
    end

    if not tryPayInfamy(player, price) then
        return
    end

    xi.monstrosity.addPurchasedInstinct(player, instinct)
    player:messageSpecial(zones[xi.zone.FERETORY].text.YOU_LEARNED_INSTINCT, xi.monstrosity.instinctNameBase + instinct)
end

local function buyBuff(player, option)
    local buff = xi.monstrosity.teyrnonBuffs[bit.rshift(option, 8)]
    if
        buff and
        tryPayInfamy(player, buff.cost)
    then
        castBuff(player, buff)
    end
end

xi.monstrosity.teyrnonOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    player:messageText(npc, zones[xi.zone.FERETORY].text.OUT_WITH_THY_BUSINESS, true, 2)
    player:startEvent(7, player:getCurrency('infamy'))
end

-- Bits 0-7 are the menu: 0 asks for a monster page (page in bits 16 and up), 1 for the instinct page.
xi.monstrosity.teyrnonOnEventUpdate = function(player, csid, option, npc)
    if csid ~= 7 then
        return
    end

    local menu = bit.band(option, 0xFF)
    if menu == 0 then
        player:updateEvent(getPageMask(player, bit.rshift(option, 16)))
    elseif menu == 1 then
        local purchased = bit.rshift(xi.monstrosity.getPurchasedInstinctBits(player), xi.monstrosityInstinct.HUME_II)
        player:updateEvent(purchased, getLimitBreakMask(player))
    end
end

-- Bits 0-7 are the purchase: 1 a monster, 2 an instinct, 3 a buff.
local purchases =
{
    [1] = buyMonster,
    [2] = buyInstinct,
    [3] = buyBuff,
}

xi.monstrosity.teyrnonOnEventFinish = function(player, csid, option, npc)
    if csid ~= 7 then
        return
    end

    local purchase = purchases[bit.band(option, 0xFF)]
    if purchase then
        purchase(player, option)
    end
end
