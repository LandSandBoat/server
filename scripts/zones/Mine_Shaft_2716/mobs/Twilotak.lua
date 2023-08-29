-----------------------------------
-- Area: Mine Shaft 2716
-- Quest: Return to the Depths
-- NM: Twilotak
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local center =
{
    { x = -460.000, y = 121.532,  z = 20.000 }, -- Area 1
    { x = 19.982,   y = 1.532,    z = 19.937 }, -- Area 2
    { x = 499.951,  y = -118.468, z = 19.941 }, -- Area 3
}

local function randomSpotNearCenter(point, range)
    local maxRange = 0.0
    local c = point
    local spot = { x = 0.0, y = 0.0, z = 0.0 }
    maxRange = range or 10.0

    local dist = math.random(-maxRange, maxRange)

    spot.y = c.y -- Only focusing on 2D spacing for now
    spot.x = math.random(c.x - dist, c.x + dist)
    spot.z = math.sqrt(dist^2 - (spot.x - c.x)^2) + c.z

    return spot
end

local function aliveHelpers(mob)
    -- Returns a table the IDs of each remaining helper alive
    if mob:getName() ~= "Twilotak" then
        return 0
    end

    local helpers = {}
    local twilotakID = mob:getID()

    for i = 1, 6 do
        if GetMobByID(twilotakID + i):isAlive() then
            table.insert(helpers, twilotakID + i)
        end
    end

    return helpers
end

local function castingHelpers(mob)
    -- Returns a table the IDs of each living mob with the casting flag up
    if mob:getName() ~= "Twilotak" then
        return 0
    end

    local helpers = aliveHelpers(mob)
    local results = {}

    if #helpers > 0 then
        for i = 1, #helpers do
            if GetMobByID(helpers[i]):getLocalVar("[depths]castActivate") ~= 0 then
                table.insert(results, helpers[i])
            end
        end
    end

    return results
end

local function animateHelpers(mob, ability)
    if mob:getName() ~= "Twilotak" then
        return 0
    end

    -- Tell each living helper to do an animation
    local helpers = aliveHelpers(mob)
    for _, h in pairs(helpers) do
        GetMobByID(h):useMobAbility(ability)
    end
end

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    -- Can use Blood Weapon multiple times
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.BLOOD_WEAPON, cooldown = 180, hpp = 95 }, -- 3 min cooldown
        },
    })

    -- Mobs assist me
    mob:addMobMod(xi.mobMod.ASSIST, 1)

    -- Start with Blood Weapon deactivated
    mob:setLocalVar("[depths]bloodweapon", 0)

    -- Add a listener / controller for when mob casts spells
    mob:setLocalVar("[depths]animateHelpers", 0)
    mob:addListener("MAGIC_STATE_EXIT", "TWILOTAK_MAGIC_EXIT", function(twilotak, spell)
        if mob:getLocalVar("[depths]animateHelpers") == 0 then
            mob:setLocalVar("[depths]animateHelpers", 1344)
            mob:useMobAbility(1345)
        end
    end)
end

entity.onMobFight = function(mob, target)
    -- Check for out-of-range characters
    -- Standard draw-in doesn't work clean since it is based on the arena center and not the mob

    -- Get the distance from the center to the draw-in target
    local area = target:getBattlefield():getArea()
    local dist = target:checkDistance(center[area])
    local hmob

    if dist > 12 and target:getCharVar("[depths]Moved") ~= 1 then
        local newPos = randomSpotNearCenter(center[area], 10)
        target:setPos(newPos.x, newPos.y, newPos.z)
        target:setCharVar("[depths]Moved", 1)
    else
        target:setCharVar("[depths]Moved", 0)
    end

    -- Set mob mods on and off for Blood Weapon
    local weaponOn = mob:getLocalVar("[depths]bloodweapon")
    if mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and weaponOn == 0 then
        mob:addMod(xi.mod.DELAY, 2200)
        mob:setLocalVar("[depths]bloodweapon", 1)
    elseif not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and weaponOn == 1 then
        mob:delMod(xi.mod.DELAY, 2200)
        mob:setLocalVar("[depths]bloodweapon", 0)
    end

    -- See if something has triggered the helpers to animate them
    local helperAnim = mob:getLocalVar("[depths]animateHelpers")
    if helperAnim > 0 then
        animateHelpers(mob, helperAnim)
        mob:setLocalVar("[depths]animateHelpers", 0)
    end

    -- Update the spellcasting of the helpers
    local alive = aliveHelpers(mob)
    if #alive > 0 and #castingHelpers(mob) < 2 then
        local a = math.random(1, #alive)
        if GetMobByID(alive[a]):getLocalVar("[depths]castActivate") == 0 then
            GetMobByID(alive[a]):setLocalVar("[depths]castActivate", 1)
            GetMobByID(alive[a]):timer(math.random(20000, 60000), function(m)
                m:setMagicCastingEnabled(true)
            end)
        end
    end

    -- Do any helper animations queued and set casting flags for each alive mob
    for _, h in pairs(alive)  do
        hmob = GetMobByID(h)
        if hmob:getLocalVar("[depths]doAnimation") ~= 0 then
            hmob:useMobAbility(hmob:getLocalVar("[depths]doAnimation"))
            hmob:setLocalVar("[depths]doAnimation", 0)
        end
        if hmob:getLocalVar("[depths]castActivate") == 0 then
            hmob:setMagicCastingEnabled(false)
        end
    end

    -- Check for any animations that Twilotak needs to do
    if mob:getLocalVar("[depths]doAnimation") ~= 0 then
        mob:useMobAbility(mob:getLocalVar("[depths]doAnimation"))
        mob:setLocalVar("[depths]doAnimation", 0)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() >= 1343 and skill:getID() <= 1345 then
        return 0
    else
        mob:timer(2500, function(t)
            t:useMobAbility(1345)
            t:setLocalVar("[depths]animateHelpers", 1344)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
