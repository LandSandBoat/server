-----------------------------------------
-- ID: 5424
-- Item: Serene Serinette
-- Item Effect: Change Music
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local alliance = target:getAlliance()
    for i, member in alliance:pairs() do
        if member:getZoneID() == target:getZoneID() then
            member:ChangeMusic(0, 153) -- Prelude
            member:ChangeMusic(1, 153) -- Prelude
        end
    end
end
