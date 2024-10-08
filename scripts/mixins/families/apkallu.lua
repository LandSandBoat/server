require('scripts/globals/apkallu')
require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.apkallu = function(apkalluMob)
    xi.apkallu.track(apkalluMob)

    apkalluMob:addListener('SPAWN', 'APKALLU_SPAWN', function(mob)
        xi.apkallu.initialize(apkalluMob)
        if xi.apkallu.canRunAway(mob) then
            mob:setLocalVar('RunAway', 1)
        end
    end)

    apkalluMob:addListener('COMBAT_TICK', 'APKALLU_COMBAT_TICK', function(mob)
        if mob:getHPP() > 25 or mob:getLocalVar('RunAway') ~= 1 then
            return
        end

        local distance = 51
        local closest = nil
        for i = 0, mob:getPartySize() - 1 do
            local member = mob:getPartyMember(i, 0)
            if member:getID() ~= 0 and mob:getID() ~= member:getID() then
                local memberDistance = mob:checkDistance(member)
                if
                    member:getCurrentAction() == xi.action.ROAMING and
                    memberDistance <= distance
                then
                    closest = member
                    distance = memberDistance
                end
            end
        end

        if closest ~= nil then
            mob:follow(closest, xi.follow.RUN_AWAY)
            mob:setLocalVar('RunAway', 2)
        end
    end)

    apkalluMob:addListener('RUN_AWAY', 'APKALLU_RUN_AWAY', function(mob, followed)
        followed:updateEnmity(mob:getTarget())
    end)

    apkalluMob:addListener('DEATH', 'APKALLU_DEATH', function(mob)
        xi.apkallu.updateHate(mob:getZoneID(), 1)
    end)
end

return g_mixins.families.apkallu
