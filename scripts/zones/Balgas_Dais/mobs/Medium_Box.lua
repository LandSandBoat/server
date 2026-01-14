-----------------------------------
-- Area: Balga's Dais
--   NM: Medium Box
-- BCNM: Treasures and Tribulations
-----------------------------------
mixins = { require('scripts/mixins/families/mimic') }
-----------------------------------
---@type TMobEntity
local entity = {}

local armouryCratePositions =
{
    -- Area 1
    [1] =
    {
        [1] = { -136.186, 56.241, -224.183, 192 }, -- Small
        [2] = { -139.186, 56.044, -224.183, 192 }, -- Medium
        [3] = { -142.186, 56.241, -224.183, 192 }, -- Large
    },

    -- Area 2
    [2] =
    {
        [1] = { 24.045, -3.759, -24.259, 192 }, -- Small
        [2] = { 21.045, -3.956, -24.259, 192 }, -- Medium
        [3] = { 18.045, -3.759, -24.259, 192 }, -- Large
    },

    -- Area 3
    [3] =
    {
        [1] = { 183.873, -63.759, 175.816, 192 }, -- Small
        [2] = { 180.873, -63.956, 175.816, 192 }, -- Medium
        [3] = { 177.873, -63.759, 175.816, 192 }, -- Large
    },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobEngage = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local crate = GetNPCByID(battlefield:getArmouryCrate())
    if not crate then
        return
    end

    local boxId = mob:getID()
    local area  = battlefield:getArea()

    -- On engage, despawn the other two boxes
    DespawnMob(boxId - 1) -- Small Box
    DespawnMob(boxId + 1) -- Large Box

    -- Determine if this box is a winner
    if math.random(1, 3) == 1 then
        -- We won! Set to invisible and kill the box, move Armoury Crate to Medium position
        mob:setStatus(xi.status.INVISIBLE)
        mob:setHP(0)
        local pos = armouryCratePositions[area][2] -- Medium (2) position
        crate:setPos(pos[1], pos[2], pos[3], pos[4])
    else
        -- We lost... Set animation sub to 1 (Mimic) and move Armoury Crate to Small or Large position
        mob:setAnimationSub(1)
        local posIndex = math.random(1, 2) == 1 and 1 or 3 -- Small (1) or Large (3), skip Medium (2)
        local pos = armouryCratePositions[area][posIndex]
        crate:setPos(pos[1], pos[2], pos[3], pos[4])
    end
end

return entity
