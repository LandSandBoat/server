-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local drawInPos =
{
    { x = 330.00, y = -23.91, z = -89.09 },
    { x = 330.15, y = -24.00, z = -80.97 },
    { x = 323.57, y = -24.00, z = -80.17 },
    { x = 325.03, y = -24.00, z = -84.18 },
    { x = 321.71, y = -23.99, z = -87.13 },
    { x = 315.91, y = -24.14, z = -87.18 },
    { x = 315.18, y = -23.96, z = -80.03 },
    { x = 317.55, y = -23.95, z = -83.00 },
}

local mobSkills =
{
    1785,
    1786,
    1787,
    1788,
    1789,
}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 486) -- 486 + 50 gives 536 DEF
    mob:setMod(xi.mod.EVA, 355)
    mob:setMod(xi.mod.ATT, 804) -- 804 + 66 gives 870 ATT
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:addMod(xi.mod.MDEF, 12) -- 100 + 12 gives 112 MDEF
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if
        mob:getHPP() <= 25 and
        math.random() < 0.50
    then
        return 1790 -- Gates of Hell
    else
        return mobSkills[math.random(#mobSkills)]
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 10)
    else
        mob:setMod(xi.mod.REGAIN, 70)
    end

    if
        (target:getXPos() < 305 or target:getXPos() > 340 or
        target:getZPos() < -100 or target:getZPos() > -70) and
        os.time() > mob:getLocalVar("DrawInWait")
    then
        local pos = math.random(1, 8)

        target:setPos(drawInPos[pos])
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CERBERUS_MUZZLER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows
end

return entity
