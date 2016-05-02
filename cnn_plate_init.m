function net =cnn_plate_init()
rng('default');
rng(0) ;

f=1/100 ;
net.layers = {};
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(3,3,1,20, 'single'), zeros(1, 20, 'single')}}, ...
                           'stride', 1, ...
                           'pad', 0) ;
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;
net.layers{end+1} = struct('type', 'relu') ;
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(3,3,20,100, 'single'),zeros(1,100,'single')}}, ...
                           'stride', 1, ...
                           'pad', 0) ;
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [2 2], ...
                           'stride', 2, ...
                           'pad', 0) ;
net.layers{end+1} = struct('type', 'relu') ;
net.layers{end+1} = struct('type', 'conv', ...
   'weights', {{f*randn(3,3,100,1000, 'single'),zeros(1,1000,'single')}}, ...
   'stride', 1, ...
   'pad', 0) ;
net.layers{end+1} = struct('type', 'softmaxloss') ;

% Meta parameters
net.meta.inputSize = [20 20 1] ;
net.meta.trainOpts.learningRate = logspace(-3, -5, 100);
net.meta.trainOpts.numEpochs = 50 ;
net.meta.trainOpts.batchSize = 1000 ;

% Fill in defaul values
net = vl_simplenn_tidy(net) ;

end