-----------------------------------
-- When Hell Freezes Over
-- Bearclaw Pinnacle ENM (Zephyr Fan)
-- !addkeyitem ZEPHYR_FAN
-----------------------------------
local bearclawID = zones[xi.zone.BEARCLAW_PINNACLE]

local content = Battlefield:new({
    zoneId           = xi.zone.BEARCLAW_PINNACLE,
    battlefieldId    = xi.battlefield.id.WHEN_HELL_FREEZES_OVER,
    maxPlayers       = 18,
    levelCap         = 75,
    timeLimit        = utils.minutes(15),
    index            = 2,
    entryNpc         = 'Wind_Pillar_3',
    exitNpc          = 'Wind_Pillar_Exit',
    requiredKeyItems = { xi.ki.ZEPHYR_FAN, message = bearclawID.text.ZEPHYR_RIPS },
    grantXP          = 3000,
})

-- Spawning function for this battlefield. Spawns a wave of 1-3 Snow Devils of either all BLM or all WAR

local function spawnSnowDevils(battlefield)
    local base   = bearclawID.mob.SNOW_DEVIL + (battlefield:getArea() - 1) * 8
    local offset = math.random(0, 1) * 3
    local count  = math.random(0, 2)
    local wave   = battlefield:getLocalVar('wave')

    for i = 0, count do
        local id  = base + offset + i
        local mob = GetMobByID(id)

        if mob then
            mob:spawn()

            -- Update emnity.
            wave  = battlefield:getLocalVar('wave')
            if wave >= 1 then
                local players = battlefield:getPlayers()
                for _, player in pairs(players) do
                    if player:isAlive() then
                        mob:updateEnmity(player)
                        break
                    end
                end
            end
        end
    end

    -- Handle progress tracking.
    battlefield:setLocalVar('nextWaveDelay', 0) -- Reset delay.
    battlefield:setLocalVar('wave', wave + 1)   -- All mobs poped. We are in this wave number.
end

-- Defines the monsters contained within this battlefield and defines a custom win condition. (4 waves completed)
-- We set all mobs spawned to false, and handle the wave spawning logic in onBattlefieldTick.
-- Any logic for spawning monsters in waves should be handled outside of content.groups to avoid them passing through initialization.

content.groups =
{
    {
        mobs = { 'Snow_Devil_war', 'Snow_Devil_blm' },
        spawned = false,

        allDeath = function(battlefield, mob)
            -- We defeated wave 4 or higher.
            if battlefield:getLocalVar('wave') >= 4 then
                content:handleAllMonstersDefeated(battlefield, mob)

            -- We defeated wave 1, 2 or 3. Request next wave.
            else
                battlefield:setLocalVar('nextWaveDelay', GetSystemTime() + 5)
            end
        end,
    },
}

-- Handles wave spawning and delays
-- We call back Battlefield.onBattlefieldTick(self, battlefield, tick) to preserve the base functionality. (Many things will break without doing this)

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    local delay = battlefield:getLocalVar('nextWaveDelay')

    -- Spawns next wave after a 5 second delay
    if
        battlefield:getLocalVar('wave') == 0 or
        (delay > 0 and delay <= GetSystemTime())
    then
        spawnSnowDevils(battlefield)
    end
end

content.loot =
{
    {
        { itemId = xi.item.NONE,                   weight = 950 },
        { itemId = xi.item.CLOUD_EVOKER,           weight =  50 },
    },

    {
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.SQUARE_OF_GALATEIA,     weight = 350 },
        { itemId = xi.item.SQUARE_OF_KEJUSU_SATIN, weight = 200 },
        { itemId = xi.item.POT_OF_VIRIDIAN_URUSHI, weight = 200 },
    },

    {
        quantity = 2,
        { itemId = xi.item.NONE,                   weight = 250 },
        { itemId = xi.item.MARTIAL_GUN,            weight = 125 },
        { itemId = xi.item.MARTIAL_BHUJ,           weight = 125 },
        { itemId = xi.item.MARTIAL_STAFF,          weight = 125 },
        { itemId = xi.item.HEXEREI_CAPE,           weight = 125 },
        { itemId = xi.item.SETTLERS_CAPE,          weight = 125 },
        { itemId = xi.item.SCROLL_OF_RAISE_III,    weight = 125 },
    },
}

return content:register()
