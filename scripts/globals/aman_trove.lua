-----------------------------------
-- A.M.A.N. Trove
-- Greyson (Lower Jeuno) and the Mars and Venus Orb battlefields.
-----------------------------------
require('scripts/globals/battlefield')
-----------------------------------
xi = xi or {}
xi.amanTrove = xi.amanTrove or {}

local exploringTheTrove = 1447

local greysonEvent =
{
    NOT_ELIGIBLE = 20082,
    INTRO        = 20083,
    MENU         = 20084,
    DEPOSIT      = 20085,
}

-- Prices and limits are read by event 20084 from its own bytecode.
local voucherPrice      = 100000
local monthlyVouchers   = 5
local maxStoredVouchers = 9999

-- Observed on retail: a 45-day wait for new characters.
local minAgeDays = 45

-- Orbs sold by Greyson, indexed by event 20084 option.
local orbsForSale =
{
    [1] = { itemId = xi.item.MARS_ORB,  cost =  6 },
    [2] = { itemId = xi.item.VENUS_ORB, cost = 10 },
}

-- Vouchers bought at once, indexed by event 20084 option. The monthly limit caps option 4.
local vouchersForSale =
{
    [3] = 1,
    [4] = monthlyVouchers,
}

-- Vouchers bought this month.
-- TODO: Capture needed. The JP wiki says both "per Earth month" and "per monthly version update", so JST months stand in.
local function getVouchersBought(player)
    if player:getCharVar('[AMAN]VoucherMonth') ~= JstYear() * 100 + JstMonth() then
        return 0
    end

    return player:getCharVar('[AMAN]VouchersBought')
end

-- Turns the player away and returns true when they can't use Greyson's services yet.
local function turnAwayIneligible(player)
    if xi.settings.main.ENABLE_AMAN_TROVE ~= 1 then
        player:startEvent(greysonEvent.NOT_ELIGIBLE)
        return true
    end

    -- Observed on retail: a young character gets this message and no event.
    local ageDays = (GetSystemTime() - player:getTimeCreated()) / 86400
    if ageDays < minAgeDays then
        player:messageSpecial(zones[xi.zone.LOWER_JEUNO].text.YOU_MUST_WAIT_ANOTHER_N_DAYS, math.ceil(minAgeDays - ageDays))
        return true
    end

    -- TODO: Capture needed. The JP wiki and BG say main job 99, and 20082 asks for a deeper understanding of Records of Eminence.
    if
        player:getMainLvl() < 99 or
        not player:getEminenceCompleted(exploringTheTrove) and not player:getEminenceProgress(exploringTheTrove)
    then
        player:startEvent(greysonEvent.NOT_ELIGIBLE)
        return true
    end

    return false
end

xi.amanTrove.onGreysonTrade = function(player, npc, trade)
    if turnAwayIneligible(player) then
        return
    end

    local ID = zones[xi.zone.LOWER_JEUNO]

    -- TODO: Capture needed. This isn't in any event, so when it fires is a guess.
    if not player:getEminenceCompleted(exploringTheTrove) then
        player:messageSpecial(ID.text.NO_NEED_TO_HURRY)
        return
    end

    -- The vouchers are taken and stored when the deposit event finishes.
    local vouchers = trade:getItemQty(xi.item.SILVER_AMAN_VOUCHER)
    if vouchers > 0 then
        local newTotal = player:getCurrency('silver_aman_voucher') + vouchers
        if newTotal > maxStoredVouchers then
            player:messageSpecial(ID.text.CANT_CARRY_ANY_MORE)
            return
        end

        if npcUtil.tradeMatches(trade, { { xi.item.SILVER_AMAN_VOUCHER, vouchers } }) then
            player:setLocalVar('[AMAN]Deposit', vouchers)
            player:startEvent(greysonEvent.DEPOSIT, newTotal)
        end

        return
    end

    for _, orbId in ipairs({ xi.item.MARS_ORB, xi.item.VENUS_ORB }) do
        if npcUtil.tradeMatches(trade, { { orbId, 1 } }) then
            if player:getWornUses(orbId) == 0 then
                player:messageSpecial(ID.text.ORB_NOT_USED_YET)
                return
            end

            -- TODO: Capture needed. BG estimates 5% a fresh orb, 25% a key or copper voucher and 70% juice.
            -- The Moglification is only said to lower the juice chance a little.
            local juiceChance = player:hasKeyItem(xi.keyItem.MOGLIFICATION_AMAN_TROVE) and 65 or 70
            local roll        = math.randomInt(1, 100)
            local reward      = utils.randomEntry({ xi.item.BOTTLE_OF_ORANGE_JUICE, xi.item.BOTTLE_OF_APPLE_JUICE })
            if roll <= 5 then
                reward = orbId
            elseif roll <= 100 - juiceChance then
                reward = utils.randomEntry({ xi.item.SPECIAL_GOBBIEDIAL_KEY, xi.item.COPPER_AMAN_VOUCHER })
            end

            -- npcUtil.giveItem would refuse a fresh orb while the used one is still in the trade, so check space first.
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, reward)
                return
            end

            player:tradeComplete()
            if reward == orbId then
                player:messageSpecial(ID.text.ORB_FRESHLY_CHARGED, reward)
            else
                player:messageSpecial(ID.text.ORB_FREEBIE, reward)
            end

            npcUtil.giveItem(player, reward)

            return
        end
    end
end

xi.amanTrove.onGreysonTrigger = function(player, npc)
    if turnAwayIneligible(player) then
        return
    end

    if not player:getEminenceCompleted(exploringTheTrove) then
        player:startEvent(greysonEvent.INTRO)
        return
    end

    -- A.M.A.N. Trove (M). Observed on retail: it completes on the click, before the menu opens.
    xi.roe.onRecordTrigger(player, 3768)

    player:startEvent(greysonEvent.MENU, player:getCurrency('silver_aman_voucher'), getVouchersBought(player), player:getGil())
end

-- The client checks costs and limits before it returns an option, so everything is checked again here.
xi.amanTrove.onGreysonEventFinish = function(player, csid, option, npc)
    if csid == greysonEvent.INTRO then
        -- TODO: Capture needed. The wikis say talking to Greyson completes the record, but the event never touches it.
        xi.roe.onRecordTrigger(player, exploringTheTrove)
        return
    end

    local stored = player:getCurrency('silver_aman_voucher')

    if csid == greysonEvent.DEPOSIT then
        local vouchers = player:getLocalVar('[AMAN]Deposit')
        player:setLocalVar('[AMAN]Deposit', 0)

        if
            vouchers > 0 and
            stored + vouchers <= maxStoredVouchers and
            player:tradeComplete()
        then
            player:addCurrency('silver_aman_voucher', vouchers)
        end

        return
    end

    if csid ~= greysonEvent.MENU then
        return
    end

    local orb = orbsForSale[option]
    if orb then
        if
            stored >= orb.cost and
            npcUtil.giveItem(player, orb.itemId)
        then
            player:delCurrency('silver_aman_voucher', orb.cost)
        end

        return
    end

    local vouchers = vouchersForSale[option]
    if not vouchers then
        return
    end

    local bought = getVouchersBought(player)
    local amount = math.min(vouchers, monthlyVouchers - bought)
    local cost   = amount * voucherPrice

    if
        amount > 0 and
        player:getGil() >= cost and
        stored + amount <= maxStoredVouchers
    then
        player:delGil(cost)
        player:addCurrency('silver_aman_voucher', amount)
        player:setCharVar('[AMAN]VoucherMonth', JstYear() * 100 + JstMonth())
        player:setCharVar('[AMAN]VouchersBought', bought + amount)
    end
end

-----------------------------------
-- Battlefields
-----------------------------------

-- Exposed so server operators can tune the trove and tests can check the rolls.
xi.amanTrove.tiers =
{
    NOISE      = 1,
    THUD       = 2,
    LOUD_THUD  = 3,
    IMPOSSIBLE = 4,
}

-- The zone message key for each tier.
local tierMessage =
{
    [xi.amanTrove.tiers.NOISE     ] = 'SPOILS_NOISE',
    [xi.amanTrove.tiers.THUD      ] = 'SPOILS_THUD',
    [xi.amanTrove.tiers.LOUD_THUD ] = 'SPOILS_LOUD_THUD',
    [xi.amanTrove.tiers.IMPOSSIBLE] = 'SPOILS_IMPOSSIBLE',
}

-- Observed on retail: an upgraded chest keeps its id and only changes its look.
-- TODO: Capture needed. No capture shows a gold chest. 969 is the Terminal Coffer's gold look.
local upgradeModels =
{
    [xi.amanTrove.tiers.LOUD_THUD ] =  969,
    [xi.amanTrove.tiers.IMPOSSIBLE] = 2426,
}

-- Each chest's own look, which a respawn doesn't restore after it became a mimic or a rainbow chest.
local chestModels =
{
    ['Chest_OPlenty' ] = 967,
    ['Coffer_OPlenty'] = 966,
}

-- TODO: Capture needed. One retail run in 43 started with a rainbow chest, and no capture shows the gil bonus.
local startingRainbowChance = 2 -- Percent
local gilBonusChance        = 1 -- Per thousand
local gilBonusAmount        = 5000000

-- Per the JP wiki, before Capacity Point bonuses.
local capacityPointsOnClear = 1000

-- Tier weights are each sound's share of the retail chest opens before 2025-11. Players often stopped after a
-- loud thud, so the loud share is a floor.
-- TODO: Capture needed. The 2025-11 update lowered the loud thud odds and raised Venus's, by amounts nobody has measured.
-- TODO: Capture needed. The "left to be made" hint messages and their follow-ups.
xi.amanTrove.orbs =
{
    MARS =
    {
        chestName     = 'Chest_OPlenty',
        mimicModel    = 258,
        cofferOffset  = 0,
        cofferMinTier = xi.amanTrove.tiers.NOISE,
        -- TODO: Capture needed. Since 2025-11 the Mars upgrade can fail, and the gold/rainbow split is unknown.
        upgradeChance = 50,
        rainbowChance = 30,
        tierWeights   =
        {
            { tier = xi.amanTrove.tiers.NOISE,     weight = 819 },
            { tier = xi.amanTrove.tiers.THUD,      weight = 155 },
            { tier = xi.amanTrove.tiers.LOUD_THUD, weight =  26 },
        },
    },

    VENUS =
    {
        chestName     = 'Coffer_OPlenty',
        mimicModel    = 259,
        cofferOffset  = 3,
        -- The JP wiki and BG agree the Venus coffer is always a thud or better.
        cofferMinTier = xi.amanTrove.tiers.THUD,
        -- The JP wiki and BG say the Venus upgrade always happens, more often to rainbow.
        -- TODO: Capture needed. The gold/rainbow split.
        upgradeChance = 100,
        rainbowChance = 55,
        tierWeights   =
        {
            { tier = xi.amanTrove.tiers.NOISE,     weight = 732 },
            { tier = xi.amanTrove.tiers.THUD,      weight = 214 },
            { tier = xi.amanTrove.tiers.LOUD_THUD, weight =  54 },
        },
    },
}

-- The orb for each battlefield.
local orbByBattlefield =
{
    [xi.battlefield.id.AMAN_TROVE_MARS_HORLAIS_PEAK     ] = xi.amanTrove.orbs.MARS,
    [xi.battlefield.id.AMAN_TROVE_VENUS_HORLAIS_PEAK    ] = xi.amanTrove.orbs.VENUS,
    [xi.battlefield.id.AMAN_TROVE_MARS_WAUGHROON_SHRINE ] = xi.amanTrove.orbs.MARS,
    [xi.battlefield.id.AMAN_TROVE_VENUS_WAUGHROON_SHRINE] = xi.amanTrove.orbs.VENUS,
    [xi.battlefield.id.AMAN_TROVE_MARS_BALGAS_DAIS      ] = xi.amanTrove.orbs.MARS,
    [xi.battlefield.id.AMAN_TROVE_VENUS_BALGAS_DAIS     ] = xi.amanTrove.orbs.VENUS,
}

-- Rolls a chest's tier from the orb's weights, never below minTier.
xi.amanTrove.rollTier = function(orb, minTier)
    local candidates = {}
    local total      = 0
    for _, entry in ipairs(orb.tierWeights) do
        if entry.tier >= minTier then
            table.insert(candidates, entry)
            total = total + entry.weight
        end
    end

    local roll = math.randomInt(1, total)
    for _, entry in ipairs(candidates) do
        roll = roll - entry.weight
        if roll <= 0 then
            return entry.tier
        end
    end

    return minTier
end

-- Adds one item of the given tier to the battlefield's spoils and announces the tier to the arena.
local function addSpoils(battlefield, tier)
    local spoils = battlefield:getLocalVar('SpoilsCount') + 1

    battlefield:setLocalVar('SpoilsCount', spoils)
    battlefield:setLocalVar(string.format('SpoilsItem%d', spoils), utils.randomEntry(xi.amanTrove.loot[tier]))
    battlefield:setLocalVar(string.format('SpoilsTier%d', spoils), tier)

    local ID = zones[battlefield:getZoneID()]
    for _, player in ipairs(battlefield:getPlayers()) do
        player:messageSpecial(ID.text[tierMessage[tier]])
    end
end

local function getChests(battlefield)
    local orb    = orbByBattlefield[battlefield:getID()]
    local chests = {}
    for _, mob in ipairs(battlefield:getMobs(true, true)) do
        if mob:getName() == orb.chestName then
            table.insert(chests, mob)
        end
    end

    return chests
end

-- Each zone lists the three Mars arena coffers, then the three Venus ones.
local function getCoffer(battlefield)
    local ID = zones[battlefield:getZoneID()]

    return GetNPCByID(ID.npc.TERMINAL_COFFERS[orbByBattlefield[battlefield:getID()].cofferOffset + battlefield:getArea()])
end

-- Turns a chest gold or rainbow. The client keeps a mob's old model unless it gets a full update.
local function upgradeChest(battlefield, chest, tier)
    chest:setLocalVar('upgradeTier', tier)
    chest:setModelId(upgradeModels[tier])
    for _, player in ipairs(battlefield:getPlayers()) do
        player:sendEntityUpdateToPlayer(chest, xi.entityUpdate.ENTITY_UPDATE, xi.updateType.UPDATE_ALL_MOB)
    end
end

-- Observed on retail: unopened chests play a vanish animation, then go away.
local function vanishUnopenedChests(battlefield, exceptId)
    for _, chest in ipairs(getChests(battlefield)) do
        if
            chest:getID() ~= exceptId and
            chest:isSpawned() and
            chest:getLocalVar('opened') == 0
        then
            chest:setLocalVar('opened', 1)
            chest:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
            chest:timer(3000, function(mob)
                DespawnMob(mob:getID())
            end)
        end
    end
end

local function isInSameBattlefield(player, entity)
    local battlefield       = player:getBattlefield()
    local entityBattlefield = entity:getBattlefield()
    if
        not battlefield or
        not entityBattlefield
    then
        return false
    end

    return battlefield:getID() == entityBattlefield:getID() and battlefield:getArea() == entityBattlefield:getArea()
end

xi.amanTrove.setupBattlefield = function(battlefield)
    local chests = getChests(battlefield)
    battlefield:setLocalVar('ChestCount', #chests)

    -- Exactly one chest is a mimic, per the JP wiki and BG. The retail click order agrees.
    local mimic = table.remove(chests, math.randomInt(1, #chests))
    battlefield:setLocalVar('MimicId', mimic:getID())

    -- Observed on retail: a run can start with a rainbow chest, which is never the mimic.
    if math.randomInt(1, 100) <= startingRainbowChance then
        upgradeChest(battlefield, utils.randomEntry(chests), xi.amanTrove.tiers.IMPOSSIBLE)
    end

    -- Observed on retail: the Terminal Coffer is there and clickable from the start.
    local coffer = getCoffer(battlefield)
    battlefield:insertEntity(coffer:getTargID(), false, true)
    npcUtil.showCrate(coffer)
end

-- Observed on retail: chests sit at status 0, which also lets them be clicked.
xi.amanTrove.onChestSpawn = function(mob)
    mob:setModelId(chestModels[mob:getName()])
    mob:setAnimationSub(4, false)
    mob:setAggressive(false)
    mob:setStatus(xi.status.NORMAL)

    -- Clicking is the only way to learn what a chest holds, so nothing may target it: no attacks, spells or abilities.
    mob:setAllegiance(xi.allegiance.PLAYER)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_ASSIST))
    mob:setUnkillable(true)
    mob:hideHP(true)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

local function revealMimic(battlefield, mob, player)
    mob:setLocalVar('opened', 1)

    vanishUnopenedChests(battlefield, mob:getID())
    getCoffer(battlefield):setStatus(xi.status.DISAPPEAR)

    -- Observed on retail: the mimic model, status 1, and animation sub 5 with its mouth open.
    mob:setModelId(orbByBattlefield[battlefield:getID()].mimicModel)
    mob:setStatus(xi.status.UPDATE)
    mob:setAllegiance(xi.allegiance.MOB)
    mob:setUnkillable(false)
    mob:hideHP(false)
    mob:setAnimationSub(5, false)
    mob:setAggressive(true)
    mob:lookAt(player:getPos())
    for _, member in ipairs(battlefield:getPlayers()) do
        member:sendEntityUpdateToPlayer(mob, xi.entityUpdate.ENTITY_UPDATE, xi.updateType.UPDATE_ALL_MOB)
    end

    mob:updateClaim(player)
    mob:updateEnmity(player)

    -- Observed on retail: Ka-thwack is readied within about a second of the reveal.
    mob:useMobAbility(xi.mobSkill.KA_THWACK, player)
end

xi.amanTrove.onChestTrigger = function(player, mob)
    if
        mob:getLocalVar('opened') == 1 or
        not isInSameBattlefield(player, mob)
    then
        return
    end

    local battlefield = player:getBattlefield()
    local mimicId     = battlefield:getLocalVar('MimicId')
    if mob:getID() == mimicId then
        revealMimic(battlefield, mob, player)
        return
    end

    mob:setLocalVar('opened', 1)
    mob:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)

    local orb  = orbByBattlefield[battlefield:getID()]
    local tier = mob:getLocalVar('upgradeTier')
    addSpoils(battlefield, tier > 0 and tier or xi.amanTrove.rollTier(orb, xi.amanTrove.tiers.NOISE))

    -- Observed on retail: with two chests left, the one that isn't the mimic can turn gold or rainbow.
    -- That marks the other one as the mimic, which retail accepts.
    local opened = battlefield:getLocalVar('ChestsOpened') + 1
    battlefield:setLocalVar('ChestsOpened', opened)
    if
        opened == battlefield:getLocalVar('ChestCount') - 2 and
        math.randomInt(1, 100) <= orb.upgradeChance
    then
        local upgradeTier = math.randomInt(1, 100) <= orb.rainbowChance and xi.amanTrove.tiers.IMPOSSIBLE or xi.amanTrove.tiers.LOUD_THUD
        for _, chest in ipairs(getChests(battlefield)) do
            if
                chest:getLocalVar('opened') == 0 and
                chest:getID() ~= mimicId
            then
                upgradeChest(battlefield, chest, upgradeTier)
                break
            end
        end
    end

    -- Observed on retail: an opened chest vanishes about 15 seconds later.
    mob:timer(15000, function(chest)
        chest:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
    end)

    mob:timer(18000, function(chest)
        DespawnMob(chest:getID())
    end)
end

-- An unrevealed chest can't be targeted. If one is engaged anyway, it counts as springing the trap.
xi.amanTrove.onChestEngage = function(mob, target)
    if mob:getLocalVar('opened') == 1 then
        return
    end

    local battlefield = mob:getBattlefield()
    local mimicId     = battlefield:getLocalVar('MimicId')
    if mob:getID() ~= mimicId then
        for _, entry in ipairs(mob:getEnmityList()) do
            mob:clearEnmityForEntity(entry.entity)
        end

        mob:disengage()
    end

    local mimic = GetMobByID(mimicId)
    if not mimic then
        return
    end

    -- A pet or Trust springs it for its master.
    revealMimic(battlefield, mimic, target:getMaster() or target)
end

-- Ka-thwack is used again at every 25% of HP lost, per the JP wiki. BG says 69%, 39% and 9%.
-- Only the mimic fights: every other chest disengages in onChestEngage.
xi.amanTrove.onMimicFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local stage = mob:getLocalVar('KaThwackStage')
    if
        stage < 3 and
        mob:getHPP() <= 75 - stage * 25
    then
        mob:setLocalVar('KaThwackStage', stage + 1)
        mob:useMobAbility(xi.mobSkill.KA_THWACK, target)
    end
end

-- A mimic that wiped the party rests back to full, so the next attempt meets every Ka-thwack again.
xi.amanTrove.onMimicDisengage = function(mob)
    mob:setLocalVar('KaThwackStage', 0)
end

-- Killing the mimic brings back the Terminal Coffer, per the JP wiki, BG and FFXIclopedia.
xi.amanTrove.onMimicDeath = function(mob, player, optParams)
    local battlefield = mob:getBattlefield()
    if
        mob:getID() ~= battlefield:getLocalVar('MimicId') or
        not optParams.isKiller and not optParams.noKiller
    then
        return
    end

    getCoffer(battlefield):setStatus(xi.status.NORMAL)

    -- The JP wiki says only Coffer O'Plenty grants the title. BG says either.
    if orbByBattlefield[battlefield:getID()] == xi.amanTrove.orbs.VENUS then
        for _, member in ipairs(battlefield:getPlayers()) do
            member:addTitle(xi.title.MIMIC_MASHER)
        end
    end
end

xi.amanTrove.onCofferTrigger = function(player, npc)
    if not isInSameBattlefield(player, npc) then
        return
    end

    npcUtil.openCrate(npc, function()
        local battlefield = player:getBattlefield()
        local orb         = orbByBattlefield[battlefield:getID()]

        vanishUnopenedChests(battlefield, 0)

        -- Observed on retail since 2025: the coffer announces its own tier.
        addSpoils(battlefield, xi.amanTrove.rollTier(orb, orb.cofferMinTier))

        -- Observed on retail: spoils arrive best tier first.
        local spoils = {}
        for i = 1, battlefield:getLocalVar('SpoilsCount') do
            table.insert(spoils,
            {
                itemId = battlefield:getLocalVar(string.format('SpoilsItem%d', i)),
                tier   = battlefield:getLocalVar(string.format('SpoilsTier%d', i)),
            })
        end

        table.sort(spoils, function(a, b)
            return a.tier > b.tier
        end)

        -- Per the patch notes, a Rare item the opener already holds is dropped from the spoils without a message.
        for _, entry in ipairs(spoils) do
            if
                bit.band(GetReadOnlyItem(entry.itemId):getFlag(), xi.itemFlag.RARE) == 0 or
                not player:hasItem(entry.itemId)
            then
                player:addTreasure(entry.itemId, npc)
            end
        end

        -- BG: the gil bonus goes to whoever opens the coffer, whatever the spoils.
        if math.randomInt(1, 1000) <= gilBonusChance then
            player:addGil(gilBonusAmount)
            player:messageSpecial(zones[battlefield:getZoneID()].text.GIL_BONUS_REWARD, gilBonusAmount)
        end

        for _, member in ipairs(battlefield:getPlayers()) do
            member:addCapacityPoints(capacityPointsOnClear)
        end

        battlefield:setStatus(xi.battlefield.status.WON)
        battlefield:setLocalVar('cutsceneTimer', xi.battlefield.contents[battlefield:getID()].delayToExit)

        -- The battlefield cleans the coffer up.
        return true
    end)
end
