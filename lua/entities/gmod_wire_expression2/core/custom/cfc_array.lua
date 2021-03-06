CFCE2Lib.RegisterExtension( "cfc_e2_lib", true )

e2function array array:shuffled()
    local size = #this
    for i = size, 1, -1 do
        local rand = math.random( size )
        this[i], this[rand] = this[rand], this[i]
    end

    return this
end

e2function array array:difference( array arrayDiff )
    local difference = {}
    for _, v in pairs( this ) do
        if !table.KeyFromValue( arrayDiff, v ) then difference[#difference + 1] = v end
    end

    return difference
end

e2function array array:intersection( array arrayDiff )
    local same = {}
    local added = {}
    for _, v in pairs( this ) do
        if not added[v] then
            if table.KeyFromValue( arrayDiff, v ) then same[#same + 1] = v end
            added[v] = true
        end
    end

    return same
end

e2function array array:reversed()
    return table.Reverse( this )
end

e2function array array:sub( number n1, number n2 )
    if n1 < 1 then n1 = 1 end
    if n2 > #this then n2 = #this end

    return {unpack( this, n1, n2 )}
end

e2function array array:sub( number n )
    if n > #this then return {this[#this]} end
    return {unpack( this, n )}
end

local function compareArrays( r1, r2 )
    if type( r1 ) ~= "table" then return false end
    if type( r2 ) ~= "table" then return false end

    if #r1 ~= #r2 then return false end
    for idx = 1, #r1 do
        if r1[idx] ~= r2[idx] then return false end
    end
    return true
end
-- Index functions
local function indexOfNormalValue( arr, val )
    for idx = 1, #arr do
        if arr[idx] == val then return idx end
    end

    return 0
end

local function indexOfPackedValue( arr, val )
    for idx = 1, #arr do
        if compareArrays( arr[idx], val ) then return idx end
    end

    return 0
end

e2function number array:indexOf( entity ent )
    return indexOfNormalValue( this, ent )
end

e2function number array:indexOf( number num )
    return indexOfNormalValue( this, num )
end

e2function number array:indexOf( string str )
    return indexOfNormalValue( this, str )
end

e2function number array:indexOf( angle ang )
    return indexOfPackedValue( this, ang )
end

e2function number array:indexOf( vector vec )
    return indexOfPackedValue( this, vec )
end

e2function number array:indexOf( vector2 vec2 )
    return indexOfPackedValue( this, vec2 )
end

e2function number array:indexOf( vector4 vec4 )
    return indexOfPackedValue( this, vec4 )
end

