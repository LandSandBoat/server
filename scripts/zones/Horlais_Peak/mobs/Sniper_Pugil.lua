-----------------------------------
-- Area: Horlais Peak
--  Mob: Sniper Pugil
-- BCNM Fight: Shooting Fish
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setBehavior(xi.behavior.STANDBACK)
    mob:setMobMod(xi.mobMod.STANDBACK_RANGE, 12)
    mob:setMobSkillAttack(2088) -- Will use Counterspore as their auto-attack.
end

-- Mimics the "shared hate" behavior observed in captures. Archer Pugils assist the Sniper Pugil and seem to change targets after Sniper Pugil attacks.
-- Archer Pugils are fairly easy to pull back off of the target after this happens, so I believe it's tied to a small amount of volatile enmity gain.
entity.onMobWeaponSkill = function(target, mob, skill)
    local sniperID = mob:getID()
    local archerOneID = sniperID + 1
    local archerTwoID = sniperID + 2

    if skill:getID() == xi.mobSkill.COUNTERSPORE_1 then
        local archerOne = GetMobByID(archerOneID)
        local archerTwo = GetMobByID(archerTwoID)
        if
            archerOne and
            archerOne:isAlive()
        then
            archerOne:addEnmity(target, 0, 500)
        end

        if
            archerTwo and
            archerTwo:isAlive()
        then
            archerTwo:addEnmity(target, 0, 500)
        end
    end
end

return entity
