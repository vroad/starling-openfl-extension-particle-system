package starling.extensions._internal;
import haxe.macro.Context;
import haxe.macro.Expr;

class ParallelUtils
{   
    macro public static function For(fromInclusive:Expr, toExclusive:Expr, func:Expr)
    {
        if (Context.defined("cs") && Context.defined("starling_particle_parallelize"))
        {
            return macro
            {
                var func = $func;
                cs.system.threading.tasks.Parallel.For($fromInclusive, $toExclusive, func);
            }
        }
        
        return macro for(i in $fromInclusive ... $toExclusive) $func(i);
    }
    
    macro public static function lock(obj:Expr, block:Expr)
    {
        if (Context.defined("cs") && Context.defined("starling_particle_parallelize"))
            return macro cs.Lib.lock($obj, $block);
        
        return macro $block;
    }
}