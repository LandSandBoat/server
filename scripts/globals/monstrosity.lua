-----------------------------------
-- Monstrosity (MON)
--
-- === How does it work? ===
--
-- Monstrosity is enabled through two mechanisms: setting your job to JOB_MON (23) and zoning.
-- Currently, there are some details that seemingly can only be populated at zone-time, so switching in/out
-- of MON mode is reliant on zoning.
--
-- When you zone your job will be checked, and if it is JOB_MON, then PChar->m_PMonstrosity will get
-- populated with your relevant Monstrosity data from table defined in char_monstrosity.sql. If you don't have
-- this information yet, it'll be created and saved for you with the defaults (the starting 3 MONs and the basic instincts).
--
-- Most other logic for determining stats, exp, exp ranges, traits, etc. will check you are either JOB_MON
-- or have m_PMonstrosity populated, and then look up what main/sub job your current species is, and then
-- forward that information into the relevant code for working out stats, etc.
--
-- IT IS VITAL that m_PMonstrosity is managed correctly, or that it's existance is constantly checked.
--
-- There is _a lot_ of client-side validation for MON, but we have all the information available server-side,
-- so we make sure to validate everything that comes through the zone_in and MON equip packets. It's also important
-- to validate all things for MON, because if they're invalid the client will get stuck in a state where they can't change
-- jobs, species, instincts, or names without GM intervention.
--
-- MONs main and subjob are in lock-step, so if you are a MNK15/NIN, the NIN will also be Lv15, and you'll get all the abilities,
-- traits, and stat contributions (TODO?) from both - except for the 2H which comes from the main job.
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.monstrosity = xi.monstrosity or {}

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

-- The zones are fixed by the client menu, the level caps are not (JP wiki, BG).
-- TODO: Apply the cap on entering the zone under Belligerency.
xi.monstrosity.belligerencyCaps =
{
    [xi.zone.BUBURIMU_PENINSULA] = 30,
    [xi.zone.XARCABARD]          = 60,
    [xi.zone.ULEGUERAND_RANGE]   = 90,
}

-- Teyrnon's shop lives in data/monstrosity.yaml and does not change once loaded.
local teyrnonShop

local function getTeyrnonShop(player)
    teyrnonShop = teyrnonShop or player:getMonstrosityShop()

    return teyrnonShop
end

-----------------------------------
-- Helpers
-----------------------------------
---@param choice xi.monstrositySpecies
xi.monstrosity.unlockStartingMONs = function(player, choice)
    local data =
    {
        monstrosityId = choice,
        species       = choice,
    }

    player:setMonstrosityData(data)
end

---@param species xi.monstrositySpecies
xi.monstrosity.getSpeciesLevel = function(player, species)
    local data = player:getMonstrosityData()
    return data['levels'][species]
end

---@param species xi.monstrositySpecies
xi.monstrosity.hasUnlockedSpecies = function(player, species)
    return xi.monstrosity.getSpeciesLevel(player, species) > 0
end

---@param species xi.monstrositySpecies
xi.monstrosity.setSpeciesLevel = function(player, species, level)
    local data = player:getMonstrosityData()
    data.levels[species] = level
    player:setMonstrosityData(data)
end

---@param species xi.monstrositySpecies
xi.monstrosity.unlockSpecies = function(player, species)
    if not xi.monstrosity.hasUnlockedSpecies(player, species) then
        xi.monstrosity.setSpeciesLevel(player, species, 1)
    end
end

---@param variant xi.monstrosityVariant
xi.monstrosity.hasUnlockedVariant = function(player, variant)
    local data = player:getMonstrosityData()

    local byteOffset  = math.floor(variant / 8)
    local shiftAmount = variant % 8

    if byteOffset < 32 then
        return bit.band(data.variants[byteOffset] or 0, bit.lshift(0x01, shiftAmount)) > 0
    end

    return false
end

---@param variant xi.monstrosityVariant
xi.monstrosity.unlockVariant = function(player, variant)
    if not xi.monstrosity.hasUnlockedVariant(player, variant) then
        local data = player:getMonstrosityData()

        local byteOffset   = math.floor(variant / 8)
        local shiftAmount  = variant % 8

        if byteOffset < 32 then
            data.variants[byteOffset] = bit.bor(data.variants[byteOffset] or 0, bit.lshift(0x01, shiftAmount))
        else
            print('byteOffset out of range')
        end

        player:setMonstrosityData(data)
    end
end

-- Purchased instincts sit in bytes 20 to 23 of the instinct bitfield, one bit per instinct.
local function getPurchasedInstinctBits(player)
    local instincts = player:getMonstrosityData().instincts

    return bit.bor(instincts[20], bit.lshift(instincts[21], 8), bit.lshift(instincts[22], 16), bit.lshift(instincts[23], 24))
end

local function addPurchasedInstinct(player, purchasableInstinctId)
    local data        = player:getMonstrosityData()
    local byteOffset  = 20 + math.floor(purchasableInstinctId / 8)
    local shiftAmount = purchasableInstinctId % 8

    if byteOffset >= 20 and byteOffset < 24 then
        data.instincts[byteOffset] = bit.bor(data.instincts[byteOffset] or 0, bit.lshift(0x01, shiftAmount))
    else
        print('byteOffset out of range')
    end

    player:setMonstrosityData(data)
end

-- Benediction costs, fixed in the client event, which also plays Teyrnon's cast on the player.
local benedictionCosts =
{
    [0] = 3000, -- Dedication 1
    [1] =  400, -- Dedication 2
    [2] =   10, -- Regen
    [3] =   10, -- Refresh
    [4] =  100, -- Protect
    [5] =  100, -- Shell
    [6] =  100, -- Haste
}

local function tryPayInfamy(player, cost)
    if player:getCurrency('infamy') < cost then
        player:messageSpecial(zones[xi.zone.FERETORY].text.THY_BRAZEN_DISREGARD)
        return false
    end

    player:delCurrency('infamy', cost)
    return true
end

-- When generating Teyrnon's mask for discounts, we need a bitmask for
-- specific jobs.  Since only one quest exists for pre-ToAU jobs, use
-- Maat's Cap tracking for those.
local function hasCompletedLimitBreak(player, jobId)
    if jobId <= xi.job.SMN then
        local maatsCap = player:getCharVar('maatsCap')

        return utils.mask.getBit(maatsCap, jobId - 1)
    else
        return player:hasCompletedQuest(unpack(limitBreakQuests[jobId]))
    end
end

local function getLimitBreakMask(player)
    local limitMask = 0

    for jobId = xi.job.WAR, xi.job.RUN do
        if hasCompletedLimitBreak(player, jobId) then
            limitMask = utils.mask.setBit(limitMask, jobId - 1, true)
        end
    end

    return limitMask
end

local function hasPurchaseRequirements(player, monCategory, selectedMon)
    local selectedMonData = getTeyrnonShop(player)[monCategory][selectedMon]
    local eligibleSpecies = selectedMonData.monSpecies and xi.monstrosity.getSpeciesLevel(player, selectedMonData.monSpecies) == 0
    local eligibleVariant = selectedMonData.monVariant and not xi.monstrosity.hasUnlockedVariant(player, selectedMonData.monVariant)

    if
        eligibleSpecies or
        eligibleVariant
    then
        if selectedMonData.requirements then
            for _, reqTable in ipairs(selectedMonData.requirements) do
                if xi.monstrosity.getSpeciesLevel(player, reqTable[1]) < reqTable[2] then
                    return false
                end
            end
        end

        return true
    end

    return false
end

local function getMonPageMask(player, monCategory)
    local categoryTable = getTeyrnonShop(player)[monCategory]
    if not categoryTable then
        return 0
    end

    local pageMask = 0
    for bitPos, _ in pairs(categoryTable) do
        if hasPurchaseRequirements(player, monCategory, bitPos) then
            pageMask = utils.mask.setBit(pageMask, bitPos, true)
        end
    end

    return pageMask
end

-----------------------------------
-- Bound by C++ (DO NOT CHANGE SIGNATURE)
-----------------------------------

xi.monstrosity.onMonstrosityReturnToEntrance = function(player)
    local data = player:getMonstrosityData()

    local x      = data.entry_x
    local y      = data.entry_y
    local z      = data.entry_z
    local rot    = data.entry_rot
    local zoneId = data.entry_zone_id
    local mjob   = data.entry_mjob
    local sjob   = data.entry_sjob

    -- TODO: Sanity check

    for _, effect in pairs(player:getStatusEffects()) do
        player:delStatusEffectSilent(effect:getEffectType())
    end

    if xi.settings.main.MONSTROSITY_TELEPORT_TO_FERETORY == 1 then
        if player:getZoneID() ~= xi.zone.FERETORY then
            player:setPos(-358, -3.4, -440, 64, xi.zone.FERETORY)
            return
        end

        -- Otherwise fallthrough and exit as normal
    end

    player:changeJob(mjob)
    player:changesJob(sjob)
    player:setPos(x, y, z, rot, zoneId)
end

-----------------------------------
-- Relinquish
-----------------------------------

-- Slip damage stops Relinquish before it counts, though the recast is still spent.
local relinquishBlockers =
{
    xi.effect.POISON,
    xi.effect.BIO,
    xi.effect.DIA,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,
}

-- Any action a monster takes on the player stops Relinquish.
local relinquishInterrupts =
{
    -- The listener argument that holds the monster differs per event.
    { event = 'ATTACKED',         name = 'RELINQUISH_ATTACKED', actorArg = 2 },
    { event = 'MAGIC_TAKE',       name = 'RELINQUISH_MAGIC',    actorArg = 2 },
    { event = 'WEAPONSKILL_TAKE', name = 'RELINQUISH_SKILL',    actorArg = 1 },
}

-- Retail counts 3 s apart. Moving or a hostile action stops it without a message.
local function relinquishCountdown(player, start)
    player:timer(3000, function(playerArg)
        local pos     = playerArg:getPos()
        local count   = playerArg:getLocalVar('RELINQUISH_COUNTDOWN') - 1
        local stopped =
            playerArg:getLocalVar('RELINQUISH_INTERRUPTED') == 1 or
            playerArg:isDead() or
            pos.x ~= start.x or
            pos.z ~= start.z

        if stopped or count == 0 then
            for _, listener in ipairs(relinquishInterrupts) do
                playerArg:removeListener(listener.name)
            end

            if not stopped then
                xi.monstrosity.onMonstrosityReturnToEntrance(playerArg)
            end

            return
        end

        playerArg:messageBasic(xi.msg.basic.FERETORY_COUNTDOWN, 0, count)
        playerArg:setLocalVar('RELINQUISH_COUNTDOWN', count)
        relinquishCountdown(playerArg, start)
    end)
end

xi.monstrosity.relinquishOnAbility = function(player)
    for _, effect in ipairs(relinquishBlockers) do
        if player:hasStatusEffect(effect) then
            return
        end
    end

    local count = 4
    player:setLocalVar('RELINQUISH_INTERRUPTED', 0)
    player:setLocalVar('RELINQUISH_COUNTDOWN', count)
    for _, listener in ipairs(relinquishInterrupts) do
        player:addListener(listener.event, listener.name, function(first, second)
            local actor  = listener.actorArg == 1 and first or second
            local target = listener.actorArg == 1 and second or first
            if actor:isMob() then
                target:setLocalVar('RELINQUISH_INTERRUPTED', 1)
            end
        end)
    end

    player:messageBasic(xi.msg.basic.FERETORY_COUNTDOWN, 0, count)
    relinquishCountdown(player, player:getPos())
end

-----------------------------------
-- Debug
-----------------------------------

xi.monstrosity.unlockAll = function(player)
    -- Complete quest
    local logId = xi.questLog.OTHER_AREAS
    player:completeQuest(logId, xi.quest.id[xi.quest.area[logId]].MONSTROSITY)

    -- Add Monstrosity key item
    player:addKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION)

    local data = player:getMonstrosityData()

    -- Set all levels to 99
    for _, val in pairs(xi.monstrositySpecies) do
        data.levels[val] = 99
    end

    -- Level instincts follow from the levels. These are the purchasable ones.
    for byteOffset = 20, 23 do
        data.instincts[byteOffset] = 0xFF
    end

    -- Variants
    -- Force unlock all
    for _, val in pairs(xi.monstrosityVariant) do
        local speciesKey   = val
        local byteOffset   = math.floor(speciesKey / 8)
        local shiftAmount  = speciesKey % 8

        if byteOffset < 32 then
            data.variants[byteOffset] = bit.bor(data.variants[byteOffset] or 0, bit.lshift(0x01, shiftAmount))
        else
            print('byteOffset out of range')
        end
    end

    -- Set data
    player:setMonstrosityData(data)
end

-----------------------------------
-- Odyssean Passage (Feretory Only)
-----------------------------------

xi.monstrosity.odysseanPassageOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    local monSize         = player:getMonstrositySize()
    local hasBelligerency = player:getBelligerencyFlag() and 1 or 0

    -- Show the full menu, not the restricted one
    if xi.settings.main.MONSTROSITY_PVP_ZONE_BYPASS == 1 then
        hasBelligerency = 0
    end

    -- NOTE: The list of available zones is built from the char's list of
    -- visited zones. If you haven't visited any zones in a category it'll back
    -- out immediately.
    -- NOTE: Param5 is not consistent, Bee has seen 0, 1, and 2 so far
    -- player:startEvent(5, 0, 0, 0, 0, 2, 0, 0, 0) -- Bee
    player:startEvent(5, 0, monSize, hasBelligerency, 0, 0, 0, 0, 0)
end

xi.monstrosity.odysseanPassageOnEventUpdate = function(player, csid, option, npc)
    local zoneSelected = bit.rshift(option, 4)
    player:updateEvent(xi.monstrosity.belligerencyCaps[zoneSelected] or 0, 0, 0, 0, 1, 0, 0, 0)
end

xi.monstrosity.odysseanPassageOnEventFinish = function(player, csid, option, npc)
    local eventOption  = bit.band(option, 0xF)
    local zoneSelected = bit.rshift(option, 4)

    if eventOption == 1 then
        if zoneSelected == 0 then
            xi.monstrosity.onMonstrosityReturnToEntrance(player)
            return
        end

        -- The client only offers visited field and dungeon zones, and Belligerency zones while it is on.
        if
            not player:isMonstrosityPassageZone(zoneSelected) or
            not player:hasVisitedZone(zoneSelected) or
            (player:getBelligerencyFlag() and not xi.monstrosity.belligerencyCaps[zoneSelected])
        then
            return
        end

        -- TODO: Capture the exits for every zone. Until then a zone script places an arrival at (0, 0, 0) on its default entry point.
        local exits = player:getMonstrosityExits(zoneSelected)
        if #exits == 0 then
            player:setPos(0, 0, 0, 0, zoneSelected)
            return
        end

        local teleportPos = exits[math.randomInt(1, #exits)]
        player:setPos(teleportPos[1], teleportPos[2], teleportPos[3], teleportPos[4], zoneSelected)
    end
end

-----------------------------------
-- Feretory
-----------------------------------

xi.monstrosity.feretoryOnZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-358.000, -3.400, -440.00, 63)
    end

    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return cs
    end

    if player:getMainJob() ~= xi.job.MON then
        player:changeJob(xi.job.MON)
    end

    for _, effect in pairs(player:getStatusEffects()) do
        player:delStatusEffectSilent(effect:getEffectType())
    end

    return cs
end

xi.monstrosity.feretoryOnZoneOut = function(player)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    -- Mark all status effects so they'll survive zoning
    -- (there are some routines that will force them off anyway)
    for _, effect in pairs(player:getStatusEffects()) do
        effect:delEffectFlag(xi.effectFlag.ON_ZONE)
        effect:delEffectFlag(xi.effectFlag.LOGOUT)
    end
end

-----------------------------------
-- Aengus (Feretory NPC)
-----------------------------------

xi.monstrosity.aengusOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    local inBelligerency = player:getBelligerencyFlag() and 1 or 0
    player:startEvent(13, inBelligerency, player:getCurrency('infamy'), 0, 0, 0, 0, 0, 0)
end

xi.monstrosity.aengusOnEventFinish = function(player, csid, option, npc)
    if csid == 13 and option == 1 then
        -- Toggle
        player:setBelligerencyFlag(not player:getBelligerencyFlag())
    end
end

-----------------------------------
-- Teyrnon (Feretory NPC)
-----------------------------------

xi.monstrosity.teyrnonOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    player:startEvent(7, player:getCurrency('infamy'), 0, 0, 0, 0, 0, 0, 0)
end

xi.monstrosity.teyrnonOnEventUpdate = function(player, csid, option, npc)
    if csid == 7 then
        local optionType = bit.band(option, 0xFF)

        if optionType == 0 then
            -- Monsters

            local monPage       = bit.rshift(option, 16)
            local availableMons = getMonPageMask(player, monPage)

            player:updateEvent(availableMons, 0, 0, 0, 0, 0, 0, 0)
        elseif optionType == 1 then
            -- Instincts

            local purchasedInstincts = bit.rshift(getPurchasedInstinctBits(player), xi.monstrosityInstinct.HUME_II)
            local completedLimits    = getLimitBreakMask(player)

            player:updateEvent(purchasedInstincts, completedLimits, 0, 0, 0, 0, 0, 0)
        end
    end
end

xi.monstrosity.teyrnonOnEventFinish = function(player, csid, option, npc)
    local optionType = bit.band(option, 0xFF)

    if optionType == 1 then
        local selectedCategory = bit.band(bit.rshift(option, 8), 0xF) - 1
        local selectedMon      = bit.rshift(option, 16)
        local shopPage         = getTeyrnonShop(player)[selectedCategory] or {}
        local monData          = shopPage[selectedMon]

        if
            not monData or
            not hasPurchaseRequirements(player, selectedCategory, selectedMon)
        then
            print(string.format('Invalid Event Finish Option received by Teyrnon! (%s:%d)', player:getName(), option))
            return
        end

        if not tryPayInfamy(player, monData.infamyCost) then
            return
        end

        if monData.monSpecies then
            xi.monstrosity.unlockSpecies(player, monData.monSpecies)
        elseif monData.monVariant then
            xi.monstrosity.unlockVariant(player, monData.monVariant)
        end

        player:messageSpecial(zones[xi.zone.FERETORY].text.MAY_POSSESS_BEASTS + 3 * selectedCategory, 0, selectedMon)

    elseif optionType == 2 then
        -- Instincts: Costs are hardcoded, and adjusted based on having completed certain
        -- prerequisites.  This data is not tabled with Teyrnon, as it cannot be controlled.

        local selectedInstinct = bit.band(bit.rshift(option, 8), 0xFF)
        if
            bit.rshift(option, 16) ~= 119 or
            selectedInstinct < xi.monstrosityInstinct.HUME_II or
            selectedInstinct > xi.monstrosityInstinct.RUN or
            bit.band(getPurchasedInstinctBits(player), bit.lshift(1, selectedInstinct)) ~= 0
        then
            print(string.format('Invalid Event Finish Option received by Teyrnon! (%s:%d)', player:getName(), option))
            return
        end

        local instinctPrice = 500
        if selectedInstinct > xi.monstrosityInstinct.GALKA_II then
            instinctPrice = hasCompletedLimitBreak(player, selectedInstinct - xi.monstrosityInstinct.GALKA_II) and 5000 or 10000
        end

        if not tryPayInfamy(player, instinctPrice) then
            return
        end

        addPurchasedInstinct(player, selectedInstinct)

        -- Purchased instinct names start at 30464 in this message. Lower values name an item.
        player:messageSpecial(zones[xi.zone.FERETORY].text.YOU_LEARNED_INSTINCT, 30464 + selectedInstinct)

    elseif optionType == 3 then
        local selectedEffect = bit.rshift(option, 8)
        local cost           = benedictionCosts[selectedEffect]
        if
            not cost or
            not tryPayInfamy(player, cost)
        then
            return
        end

        switch(selectedEffect): caseof
        {
            -- 50% experience bonus 60 minutes or until a maximum bonus of 10,000 EXP is gained
            [0] = function()
                local effect   = xi.effect.DEDICATION
                local power    = 50
                local duration = utils.minutes(60)
                local subpower = 10000
                player:delStatusEffectSilent(effect)
                xi.itemUtils.addItemExpEffect(player, effect, power, duration, subpower)
            end,

            -- 100% experience bonus 60 minutes or until a maximum bonus of 2,000 EXP is gained
            [1] = function()
                local effect   = xi.effect.DEDICATION
                local power    = 100
                local duration = utils.minutes(60)
                local subpower = 2000
                player:delStatusEffectSilent(effect)
                xi.itemUtils.addItemExpEffect(player, effect, power, duration, subpower)
            end,

            [2] = function()
                player:delStatusEffectSilent(xi.effect.REGEN)
                player:addStatusEffect(xi.effect.REGEN, { power = 1, duration = 3600, origin = player, tick = 3 })
            end,

            [3] = function()
                -- A regular Refresh does overwrite this.
                player:delStatusEffectSilent(xi.effect.REFRESH)
                player:addStatusEffect(xi.effect.REFRESH, { power = 1, duration = 3600, origin = player, tick = 3 })
            end,

            [4] = function()
                local mLvl  = player:getMainLvl()
                local power = 220
                local tier  = 5

                if mLvl < 27 then
                    power = 20
                    tier = 1
                elseif mLvl < 47 then
                    power = 50
                    tier = 2
                elseif mLvl < 63 then
                    power = 90
                    tier = 3
                elseif mLvl < 76 then
                    power = 140
                    tier = 4
                end

                local bonus = 0
                if player:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
                    bonus = 2 -- 2x Tier from MOD
                end

                power = power + (bonus * tier)
                player:delStatusEffectSilent(xi.effect.PROTECT)
                player:addStatusEffect(xi.effect.PROTECT, { power = power, duration = 1800, origin = player, tier = tier })
            end,

            [5] = function()
                local mLvl  = player:getMainLvl()

                -- Shell V (75/256)
                local power = 2930
                local tier  = 5

                if mLvl < 37 then
                    power = 1055 -- Shell I   (27/256)
                    tier = 1
                elseif mLvl < 57 then
                    power = 1641 -- Shell II  (42/256)
                    tier = 2
                elseif mLvl < 68 then
                    power = 2188 -- Shell III (56/256)
                    tier = 3
                elseif mLvl < 76 then
                    power = 2617 -- Shell IV  (67/256)
                    tier = 4
                end

                local bonus = 0
                if player:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
                    bonus = 39   -- (1/256 bonus buff per tier of spell)
                end

                power = power + (bonus * tier)
                player:delStatusEffectSilent(xi.effect.SHELL)
                player:addStatusEffect(xi.effect.SHELL, { power = power, duration = 1800, origin = player, tier = tier })
            end,

            [6] = function()
                player:delStatusEffectSilent(xi.effect.HASTE)
                player:addStatusEffect(xi.effect.HASTE, { power = 1000, duration = 600, origin = player })
            end,
        }
    end
end

-----------------------------------
-- Maccus (Feretory NPC)
-----------------------------------

xi.monstrosity.maccusOnTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    player:startEvent(9, 285, 2, 2, 0, 0, 0, 0, 0)
end
