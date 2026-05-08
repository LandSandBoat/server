-----------------------------------
-- Pulling the Strings
-- Level 60 ENM
-- !addkeyitem SHAFT_GATE_OPERATING_DIAL
-----------------------------------
local mineshaftID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

local content = Battlefield:new({
    zoneId           = xi.zone.MINE_SHAFT_2716,
    battlefieldId    = xi.battlefield.id.PULLING_THE_STRINGS,
    maxPlayers       = 1,
    levelCap         = 60,
    allowSubjob      = false,
    timeLimit        = utils.minutes(15),
    index            = 3,
    entryNpc         = '_0d0',
    exitNpcs         = { '_0d1', '_0d2', '_0d3' },
    requiredKeyItems = { xi.ki.SHAFT_GATE_OPERATING_DIAL, message = mineshaftID.text.SNAPS_IN_TWO, },
    grantXP          = 2000,
    armouryCrates    =
    {
        mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 1,
        mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 8,
        mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 15,
    },
})

-----------------------------------
-- Registration Gate - DNC, SCH, GEO and RUN cannot run this ENM
-----------------------------------
function content:onEntryEventUpdate(player, csid, option, npc)
    if not player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        local job = player:getMainJob()

        if job >= xi.job.DNC then
            player:updateEvent(xi.battlefield.returnCode.REQS_NOT_MET)
            player:setLocalVar('noPosUpdate', 1)
            return 0
        end
    end

    return Battlefield.onEntryEventUpdate(self, player, csid, option, npc)
end

-----------------------------------
-- Initialize Battlefield
-----------------------------------
function content:onBattlefieldInitialize(battlefield)
    -- We store the initiators job to determine which type of fantoccini model to use and to determine the type of loot comes from the armoury crate.
    local initiatorJob = GetPlayerByID(battlefield:getInitiator()):getMainJob() or xi.job.WAR

    battlefield:setLocalVar('initiatorJob', initiatorJob)

    Battlefield.onBattlefieldInitialize(self, battlefield)
end

-----------------------------------
-- Battlefield Groups
-----------------------------------
content.groups =
{
    {
        mobIds =
        {
            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN,
            },

            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 7,
            },

            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 14,
            },
        },
        superlinkGroup = 1,
    },

    {
        mobIds =
        {
            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 2,
            },

            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 9,
            },

            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 16,
            },
        },
        superlinkGroup = 1,
        allDeath = utils.bind(content.handleAllMonstersDefeated, content),
    },

    {
        mobIds =
        {
            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 3, -- Funguar, Lizard
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 4, -- Wyvern
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 5, -- Avatar
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 6, -- Automaton
            },

            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 10, -- Funguar, Lizard
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 11, -- Wyvern
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 12, -- Avatar
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 13, -- Automaton
            },

            {
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 17, -- Funguar, Lizard
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 18, -- Wyvern
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 19, -- Avatar
                mineshaftID.mob.MOBLIN_FANTOCCINIMAN + 20, -- Automaton
            },
        },
        superlinkGroup = 1,
        spawned = false,
    },
}

-----------------------------------
-- Loot Tables
-----------------------------------
local lootTables =
{
    [ 1] = xi.item.JANIZARY_EARRING,
    [ 2] = xi.item.COUNTER_EARRING,
    [ 3] = xi.item.HEALING_FEATHER,
    [ 4] = xi.item.SPIRIT_LANTERN,
    [ 5] = xi.item.SANATION_RING,
    [ 6] = xi.item.ASSASSINS_RING,
    [ 7] = xi.item.VIAL_OF_REFRESH_MUSK,
    [ 8] = xi.item.TACTICAL_RING,
    [ 9] = xi.item.PACIFIST_RING,
    [10] = xi.item.GETSUL_RING,
    [11] = xi.item.DEADEYE_EARRING,
    [12] = xi.item.GAMUSHARA_EARRING,
    [13] = xi.item.NARUKO_EARRING,
    [14] = xi.item.BAG_OF_WYVERN_FEED,
    [15] = xi.item.ASTRAL_POT,
    [16] = xi.item.DEATH_CHAKRAM,
    [17] = xi.item.CORSAIR_BULLET_POUCH,
    [18] = { xi.item.ATTUNER, xi.item.TACTICAL_PROCESSOR, xi.item.DRUM_MAGAZINE, xi.item.EQUALIZER, xi.item.TARGET_MARKER, xi.item.MANA_CHANNELER, xi.item.ERASER, xi.item.SMOKE_SCREEN },
}

local function getLootPool(battlefield)
    -- Get loot table based on job. PUP gets two chances to drop an additional attachment.
    local key            = battlefield:getLocalVar('initiatorJob')
    local lootPool       = lootTables[key]
    local bonusLootPools = {}

    if type(lootPool) == 'table' then
        lootPool = utils.randomEntry(lootPool)
        -- Two independent 20 percent chances to drop additional attachments if the initiator is a PUP.
        local bonusAttachment = lootTables[key]
        if key == xi.job.PUP and type(bonusAttachment) == 'table' then
            for _ = 1, 2 do
                if math.random(1, 100) <= 20 then
                    table.insert(bonusLootPools, utils.randomEntry(bonusAttachment))
                end
            end
        end
    end

    -- Build loot table.
    local lootTable =
    {
        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = xi.item.SACK_OF_LITTLE_WORM_MULCH, weight =  5000 },
        },

        {
            { itemId = xi.item.NONE,                      weight =  5000 },
            { itemId = lootPool,                          weight =  5000 },
        },
    }

    for _, bonusLootPool in ipairs(bonusLootPools) do
        table.insert(lootTable,
        {
            { itemId = bonusLootPool,                     weight = 10000 },
        })
    end

    return lootTable or content.loot
end

function content:handleOpenArmouryCrate(player, npc)
    npcUtil.openCrate(npc, function()
        local battlefield = player:getBattlefield()
        local lootPool    = getLootPool(battlefield)

        self:handleLootRolls(battlefield, lootPool, npc, player:getMod(xi.mod.MOGHANCEMENT_GIL_BONUS_P))
        battlefield:setStatus(xi.battlefield.status.WON)

        return true
    end)
end

return content:register()
