"""
ArithmeticBlocks
"""

export tSaturationDynamicBlock

mutable struct tSaturationDynamicBlock <: AbstractArithmeticBlock
    inport::Vector{InPort}
    outport::Vector{OutPort}
    op::Vector{Symbol}

    function tSaturationDynamicBlock(op::Vector{Symbol})
        @createblock new(Vector{InPort}(), Vector{OutPort}(), op) length(op) 1
    end
end


"""
IO
"""

function Base.show(io::IO, blk::AddBlock)
    println(io, "tSaturationDynamicBlock($(blk.op))")
end

"""
to expr
"""

function _toexpr(blk::tSaturationDynamicBlock)
    inputvalue = _toexpr(blk.inport[1])
    upperlimit = _toexpr(blk.inport[2])
    lowerlimit = _toexpr(blk.inport[3])
    
    #入力端子,上限,下限の順で配列に
    
    Expr(:if, Expr(:comparison, lowerlimit, :>=, _toexpr(blk.inport[1])), lowerlimit, Expr(:if, Expr(:comparison, upperlimit, :<=, _toexpr(blk.inport[1])), upperlimit, _toexpr(blk.inport[1])))

    #Expr(:if, Expr(:comparison, upperlimit, :<=, _toexpr(blk.inport[1])), upperlimit, _toexpr(blk.inport[1]))
    
end

