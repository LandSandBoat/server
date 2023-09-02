-----------------------------------
-- Nyzul Isle Global
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}

xi.nyzul.objective =
{
    ELIMINATE_ENEMY_LEADER      = 1,
    ELIMINATE_SPECIFIED_ENEMIES = 2,
    ACTIVATE_ALL_LAMPS          = 3,
    ELIMINATE_SPECIFIED_ENEMY   = 4,
    ELIMINATE_ALL_ENEMIES       = 5,
    FREE_FLOOR                  = 6,
}

xi.nyzul.lampsObjective =
{
    REGISTER     = 1,
    ACTIVATE_ALL = 2,
    ORDER        = 3,
}

xi.nyzul.gearObjective =
{
    AVOID_AGRO     = 1,
    DO_NOT_DESTROY = 2,
}

xi.nyzul.penalty =
{
    TIME   = 1,
    TOKENS = 2,
    PATHOS = 3,
}

-- used 1 time in instance file
xi.nyzul.FloorLayout =
{
    [ 0] = {   -20, -0.5, -380 }, -- boss floors 20, 40, 60, 80
--  [ ?] = {  -491, -4.0, -500 }, -- boss floor 20 confirmed
    [ 1] = {   380, -0.5, -500 },
    [ 2] = {   500, -0.5,  -20 },
    [ 3] = {   500, -0.5,   60 },
    [ 4] = {   500, -0.5, -100 },
    [ 5] = {   540, -0.5, -140 },
    [ 6] = {   460, -0.5, -219 },
    [ 7] = {   420, -0.5,  500 },
    [ 8] = {    60, -0.5, -335 },
    [ 9] = {    20, -0.5, -500 },
    [10] = {   -95, -0.5,   60 },
    [11] = {   100, -0.5,  100 },
    [12] = {  -460, -4.0, -180 },
    [13] = {  -304, -0.5, -380 },
    [14] = {  -380, -0.5, -500 },
    [15] = {  -459, -4.0, -540 },
    [16] = {  -465, -4.0, -340 },
    [17] = { 504.5,  0.0,  -60 },
--  [18] = {   580,  0.0,  340 },
--  [19] = {   455,  0.0, -140 },
--  [20] = {   500,  0.0,   20 },
--  [21] = {   500,    0,  380 },
--  [22] = {   460,    0,  100 },
--  [23] = {   100,    0, -380 },
--  [24] = { -64.5,    0,   60 },
}

-- Local functions
local function getTokenRate(instance)
    local partySize = instance:getLocalVar("[Nyzul]PlayerCount")
    local rate      = 1

    if partySize > 3 then
        rate = rate - (partySize - 3) * 0.1
    end

    return rate
end

-- Global functions

xi.nyzul.calculateTokens = function(instance)
    local relativeFloor   = xi.nyzul.getRelativeFloor(instance)
    local rate            = getTokenRate(instance)
    local potentialTokens = instance:getLocalVar('potential_tokens')
    local floorBonus      = 0

    if relativeFloor > 1 then
        floorBonus = 10 * math.floor((relativeFloor - 1) / 5)
    end

    potentialTokens = math.floor(potentialTokens + (200 + floorBonus) * rate)

    return potentialTokens
end

-- Handle floor 100 reward.
xi.nyzul.handleRunicKey = function(mob)
    local instance = mob:getInstance()

    if instance:getLocalVar("[Nyzul]CurrentFloor") == 100 then
        local chars      = instance:getChars()
        local startFloor = instance:getLocalVar('Nyzul_Isle_StartingFloor')

        for _, entity in pairs(chars) do
            -- Does players Runic Disk have data saved to a floor of entering or higher
            if
                entity:getVar('NyzulFloorProgress') + 1 >= startFloor and
                not entity:hasKeyItem(xi.ki.RUNIC_KEY)
            then
                -- On early version only initiator of floor got progress saves and key credit
                if not xi.settings.main.RUNIC_DISK_SAVE then
                    if entity:getID() == instance:getLocalVar('diskHolder') then
                        if npcUtil.giveKeyItem(entity, xi.ki.RUNIC_KEY) then
                            entity:setVar('NyzulFloorProgress', 0)
                        end
                    end

                -- Anyone can get a key on 100 win if disk passed check
                else
                    npcUtil.giveKeyItem(entity, xi.ki.RUNIC_KEY)
                end
            end
        end
    end
end

xi.nyzul.getTokenPenalty = function(instance)
    local floorPenalities = instance:getLocalVar('tokenPenalty')
    local rate            = getTokenRate(instance)

    return math.floor(117 * rate * floorPenalities)
end
