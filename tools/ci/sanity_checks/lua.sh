#!/bin/bash

# Requires the following packages:
# Package manager: luarocks
# luarocks install luacheck --local
# luarocks install lanes --local

any_issues=false

if [[ $# -gt 0 ]]; then
    targets=("$@")
else
    mapfile -t targets < <(find scripts settings/default modules -name '*.lua')
fi

global_funcs=`python << EOF
import re
file = open('src/map/lua/luautils.cpp', 'r')
data = file.read()
file.close()
# Find all bound global functions
matches = re.findall(r'(?<=set_function\(\")(.*)(?=\",)', data)
# Make sure they're capitalized
matches = map(lambda s: s[:1].upper() + s[1:] if s else '', matches)
# Print space-delimited for piping back to bash
print(*matches)
EOF`

global_objects=(
    xi
    ai
    os
    sleep
    _
    _G

    Module
    Override
    super
    applyOverride

    common
    zones
    quests
    utils
    npcUtil

    mixins
    g_mixins
    applyMixins
    mixinOptions

    set
    printf
    fmt
    switch
    getVanaMidnight
    getVanadielMoonCycle
    getMidnight

    Mission
    Quest
    HiddenQuest
    InteractionGlobal
    InteractionLookup
    Action
    actionUtil
    interactionUtil
    KeyItemAction
    LambdaAction
    Message
    NoAction
    Sequence
    Container
    Event
    Battlefield
    BattlefieldMission
    BattlefieldQuest
    Limbus
    SeasonalEvent

    onBattlefieldHandlerInitialize
    applyResistanceAddEffect

    addBonuses
    addBonusesAbility
    applyResistanceEffect
    calculateDuration
    finalMagicAdjustments
    finalMagicNonSpellAdjustments
    getBaseCure
    getCurePower
    getCurePowerOld
    getCureFinal
    getBaseCureOld
    isValidHealTarget

    ForceCrash
    BuildString

    GetFirstID

    ReloadSynthRecipes

    after_each
    assert
    before_each
    DebugTest
    describe
    InfoTest
    it
    mock
    setup
    spy
    stub
    teardown
)

ignores=(
)

ignore_rules=(
    311 # value assigned to variable <> is unused
    542 # empty if branch
)

binding_usage_output=$(python tools/ci/sanity_checks/lua_binding_usage.py 2>&1 || true)

if [[ -n "$binding_usage_output" ]]; then
    any_issues=true
    echo "## :x: Lua Checks Failed"
    echo "### Lua Binding Usage:"
    echo "$binding_usage_output"
fi

for file in "${targets[@]}"; do
    [[ -f $file && ($file == scripts/**/*.lua || $file == settings/default/*.lua || $file == modules/**/*.lua) ]] || continue

    # Run tools and capture output
    luacheck_output=$(luacheck "$file" \
    --quiet --jobs 4 --no-config --codes \
    --no-color \
    --no-unused-args \
    --no-max-line-length \
    --max-cyclomatic-complexity 30 \
    --globals ${global_funcs[@]} ${global_objects[@]} \
    --ignore ${ignores[@]} ${ignore_rules[@]} | grep -v "Total:" 2>&1 || true)
    stylecheck_output=$(python tools/ci/sanity_checks/lua_stylecheck.py "$file" 2>&1 || true)

    # Check if there were issues
    if [[ -n "$luacheck_output" || -n "$stylecheck_output" ]]; then
        if ! $any_issues; then
            echo "## :x: Lua Checks Failed"
            any_issues=true
        fi

        if [[ -n "$luacheck_output" ]]; then
            echo "#### Luacheck Errors:"
            echo "> $file"
            echo '```'
            echo "$luacheck_output" | sed \
                -e '/^Checking /d' \
                -e '/^\s*$/d' \
                -e 's/^[[:space:]]\{4\}//'
            echo '```'
            echo
        fi
        [[ -n "$stylecheck_output" ]] && echo "$stylecheck_output"
        echo
    fi
done

$any_issues && exit 1 || exit 0
