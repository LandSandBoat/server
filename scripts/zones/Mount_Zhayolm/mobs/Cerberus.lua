-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local drawInPos =
{
    { 330.00, -23.91, -89.09 },
    { 330.15, -24.00, -80.97 },
    { 323.57, -24.00, -80.17 },
    { 325.03, -24.00, -84.18 },
    { 321.71, -23.99, -87.13 },
    { 315.91, -24.14, -87.18 },
    { 315.18, -23.96, -80.03 },
    { 317.55, -23.95, -83.00 },
}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 486) -- 486 + 50 gives 536 DEF
    mob:setMod(xi.mod.EVA, 355)
    mob:setMod(xi.mod.ATT, 804) -- 804 + 66 gives 870 ATT
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:addMod(xi.mod.MDEF, 12) -- 100 + 12 gives 112 MDEF
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    -- skills without GoH
    local mobSkills = { 1785, 1786, 1787, 1788, 1789 }
    -- if less than 25% HP
    if mob:getHPP() <= 25 then
        -- select GoH with 50% probability
        if math.random() < 0.50 then
            return 1790
        -- else select random skill
        else
            return mobSkills[math.random(#mobSkills)]
        end
    -- else select random skill
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

    -- retail cerb uses weird custom draw-in mechanism to fixed points
    local drawInWait = mob:getLocalVar("DrawInWait")

    if
        (target:getXPos() < 305 or target:getXPos() > 340) and
        os.time() > drawInWait
    then
        local rot = target:getRotPos()
        local position = math.random(1, 8)
        target:setPos(drawInPos[position][1], drawInPos[position][2], drawInPos[position][3], rot)
        mob:messageBasic(232, 0, 0, target)
        mob:setLocalVar("DrawInWait", os.time() + 2)
    elseif
        (target:getZPos() < -100 or target:getZPos() > -70) and
        os.time() > drawInWait
    then
        local rot = target:getRotPos()
        local position = math.random(1, 8)
        target:setPos(drawInPos[position][1], drawInPos[position][2], drawInPos[position][3], rot)
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
