"""
FunctionBlocks
"""

export SaturationDynamicBlock

mutable struct SaturationDynamicBlock <: AbstractFunctionBlock
    inport::Vector{InPort}
    outport::Vector{OutPort}

    function SaturationDynamicBlock(::Type{Tv} = Float64) where Tv
        @createblock new(Vector{InPort}(), Vector{OutPort}()) 3 1
    end
end


"""
IO
"""

function Base.show(io::IO, blk::SaturationDynamicBlock)
    println(io, "SaturationDynamic()")
end

"""
to expr
"""

function _toexpr(blk::SaturationDynamicBlock)
    inputvalue = _toexpr(blk.inport[1])
    upperlimit = _toexpr(blk.inport[2])
    lowerlimit = _toexpr(blk.inport[3])
    
    #入力端子,上限,下限の順で配列に
    
    Expr(:if, Expr(:comparison, lowerlimit, :>=, _toexpr(blk.inport[1])), lowerlimit, Expr(:if, Expr(:comparison, upperlimit, :<=, _toexpr(blk.inport[1])), upperlimit, _toexpr(blk.inport[1])))

    #Expr(:if, Expr(:comparison, upperlimit, :<=, _toexpr(blk.inport[1])), upperlimit, _toexpr(blk.inport[1]))
    
end

