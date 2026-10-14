-----------------------------------
-- Monstrosity - Teyrnon (Feretory)
-- Sells families, variants, instincts and buffs for infamy.
-----------------------------------
require('scripts/globals/quests')
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

-- Purchased instinct names start at this message param. Lower values name an item.
local instinctNameBase = 30464

-- The job instincts, which cost less once that job's limit is broken.
local instinctJobs =
{
    [xi.monstrosityInstinct.WAR] = xi.job.WAR,
    [xi.monstrosityInstinct.MNK] = xi.job.MNK,
    [xi.monstrosityInstinct.WHM] = xi.job.WHM,
    [xi.monstrosityInstinct.BLM] = xi.job.BLM,
    [xi.monstrosityInstinct.RDM] = xi.job.RDM,
    [xi.monstrosityInstinct.THF] = xi.job.THF,
    [xi.monstrosityInstinct.PLD] = xi.job.PLD,
    [xi.monstrosityInstinct.DRK] = xi.job.DRK,
    [xi.monstrosityInstinct.BST] = xi.job.BST,
    [xi.monstrosityInstinct.BRD] = xi.job.BRD,
    [xi.monstrosityInstinct.RNG] = xi.job.RNG,
    [xi.monstrosityInstinct.SAM] = xi.job.SAM,
    [xi.monstrosityInstinct.NIN] = xi.job.NIN,
    [xi.monstrosityInstinct.DRG] = xi.job.DRG,
    [xi.monstrosityInstinct.SMN] = xi.job.SMN,
    [xi.monstrosityInstinct.BLU] = xi.job.BLU,
    [xi.monstrosityInstinct.COR] = xi.job.COR,
    [xi.monstrosityInstinct.PUP] = xi.job.PUP,
    [xi.monstrosityInstinct.DNC] = xi.job.DNC,
    [xi.monstrosityInstinct.SCH] = xi.job.SCH,
    [xi.monstrosityInstinct.GEO] = xi.job.GEO,
    [xi.monstrosityInstinct.RUN] = xi.job.RUN,
}

-- Only one limit break quest exists for each pre-ToAU job, so those read Maat's Cap instead.
local limitBreakQuests =
{
    [xi.job.BLU] = { xi.questLog.AHT_URHGAN,  xi.quest.id.ahtUrhgan.THE_BEAST_WITHIN           },
    [xi.job.COR] = { xi.questLog.AHT_URHGAN,  xi.quest.id.ahtUrhgan.BREAKING_THE_BONDS_OF_FATE },
    [xi.job.PUP] = { xi.questLog.BASTOK,      xi.quest.id.bastok.ACHIEVING_TRUE_POWER          },
    [xi.job.DNC] = { xi.questLog.JEUNO,       xi.quest.id.jeuno.A_FURIOUS_FINALE               },
    [xi.job.SCH] = { xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.SURVIVAL_OF_THE_WISEST    },
    [xi.job.GEO] = { xi.questLog.ADOULIN,     xi.quest.id.adoulin.ELEMENTARY_MY_DEAR_SYLVIE    },
    [xi.job.RUN] = { xi.questLog.ADOULIN,     xi.quest.id.adoulin.ENDEAVORING_TO_AWAKEN        },
}

-- Protect and Shell follow the spell tier for the Monipulator's level: the first row whose level it is under.
local protectTiers =
{
    { level = 27,        power = 20  },
    { level = 47,        power = 50  },
    { level = 63,        power = 90  },
    { level = 76,        power = 140 },
    { level = math.huge, power = 220 },
}

-- Shell power is in 1/256ths of 10000: Shell I is 27/256, Shell V 75/256.
local shellTiers =
{
    { level = 37,        power = 1055 },
    { level = 57,        power = 1641 },
    { level = 68,        power = 2188 },
    { level = 76,        power = 2617 },
    { level = math.huge, power = 2930 },
}

-- Buffs by menu slot. The costs are fixed in the client event. Dedication pays its bonus until
-- expCap exp is gained. tierBonus is added per tier under ENHANCES_PROT_SHELL_RCVD.
local buffs =
{
    [0] = { cost = 3000, effect = xi.effect.DEDICATION, duration = 3600, power = 50,   expCap = 10000 },
    [1] = { cost = 400,  effect = xi.effect.DEDICATION, duration = 3600, power = 100,  expCap = 2000  },
    [2] = { cost = 10,   effect = xi.effect.REGEN,      duration = 3600, power = 1,    tick = 3       },
    [3] = { cost = 10,   effect = xi.effect.REFRESH,    duration = 3600, power = 1,    tick = 3       },
    [4] = { cost = 100,  effect = xi.effect.PROTECT,    duration = 1800, tiers = protectTiers, tierBonus = 2  },
    [5] = { cost = 100,  effect = xi.effect.SHELL,      duration = 1800, tiers = shellTiers,   tierBonus = 39 },
    [6] = { cost = 100,  effect = xi.effect.HASTE,      duration = 1800, power = 1000 },
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

    return player:hasCompletedQuest(unpack(limitBreakQuests[jobId]))
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

    -- A race II instinct costs 500. A job instinct costs 10000, or 5000 once that job's limit is broken.
    local job   = instinctJobs[instinct]
    local price = 500
    if job then
        price = 10000
        if hasCompletedLimitBreak(player, job) then
            price = 5000
        end
    end

    if not tryPayInfamy(player, price) then
        return
    end

    xi.monstrosity.addPurchasedInstinct(player, instinct)
    player:messageSpecial(zones[xi.zone.FERETORY].text.YOU_LEARNED_INSTINCT, instinctNameBase + instinct)
end

local function buyBuff(player, option)
    local buff = buffs[bit.rshift(option, 8)]
    if
        not buff or
        not tryPayInfamy(player, buff.cost)
    then
        return
    end

    player:delStatusEffectSilent(buff.effect)

    if buff.expCap then
        xi.itemUtils.addItemExpEffect(player, buff.effect, buff.power, buff.duration, buff.expCap)
        return
    end

    local power = buff.power
    local tier
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
