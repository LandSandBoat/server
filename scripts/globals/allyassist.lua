xi = xi or {}

xi.ally =
{
    ASSIST_PLAYER = 1,
    ASSIST_RANDOM = 2,

    startAssist = function(entity, assistMode)
        if assistMode == nil then
            assistMode = xi.ally.ASSIST_PLAYER
        end

        local mobs
        local players
        local allies = {}

        if entity:getBattlefield() ~= nil then
            mobs = entity:getBattlefield():getMobs()
            players = entity:getBattlefield():getPlayers()
        elseif entity:getInstance() ~= nil then
            mobs = entity:getInstance():getMobs()
            players = entity:getInstance():getChars()
        end

        local targetMobs = {}
        for i, mob in pairs(mobs) do
            if mob:isSpawned() and mob:isAlive() then
                if mob:isAlly() then
                    table.insert(allies, mob)
                else
                    table.insert(targetMobs, mob)
                end
            end
        end

        -- In this mode, find a player with a battle target, and assist that player
        if assistMode == xi.ally.ASSIST_PLAYER then
            local assistTarget = 0

            -- Loop players and find someone who is engaged in battle
            for i, player in pairs(players) do
                local battleTarget = player:getTarget()
                if battleTarget ~= nil then
                    assistTarget = battleTarget:getTargID()
                    break
                end
            end

            -- Attack their target if found. If none found, we'll fall to xi.ally.ASSIST_RANDOM.
            -- A variety of reasons could cause this - players have hate but are not engaged is one.
            -- Being aggroed when not engaged is another.

            if assistTarget > 0 then
                for _, ally in ipairs(allies) do
                    ally:engage(assistTarget)
                end

                return
            end
        end

        -- xi.ally.ASSIST RANDOM - also a fallback for xi.ally.ASSIST_PLAYER
        -- Pick an enemy to attack. Some allies do this intentionally. Some allies start to attack on their own if
        -- a player stalls too long. This can be used to set a target in both cases.

        local target

        if #targetMobs > 0 then
            target = targetMobs[math.random(1, #targetMobs)]
        end

        if not target then
            return
        end

        for _, ally in ipairs(allies) do
            ally:engage(target:getTargID())
        end
    end
}
