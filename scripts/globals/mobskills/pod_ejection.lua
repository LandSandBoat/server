---------------------------------------------
-- Pod Ejection
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    local pod = GetMobByID(mob:getID() + 1)
    local currentForm = mob:getLocalVar("form")

    if not pod:isSpawned() and currentForm == 2 then -- proto-omega final form
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local battlefield = mob:getBattlefield()
    local pod = GetMobByID(mob:getID() + 1)
    if battlefield and not pod:isSpawned() then
        local players = battlefield:getPlayers()
        local random = math.random(1, #players)
        local X = mob:getXPos()
        local Y = mob:getYPos()
        local Z = mob:getZPos()
        pod:spawn()
        pod:setPos(X,Y,Z)
        pod:updateEnmity(players[random])
    end
    return 0
end