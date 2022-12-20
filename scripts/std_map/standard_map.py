import numpy as np
import matplotlib.pyplot as plt


class standard_map:
    """ Represents a standard map

    The standard map is described as
    y' = y - k/2pi * sin(2 pi x)
    x' = x + y'

    Attributes:
        npts: number of starting points
        niter: number of iterations on the map
        k (float): parameter governing the perturbation of the map
        x (numpy array): size (npts, niter) containing the coordinate x
        y (numpy array): size (npts, niter) containing the coordinate y
    """

    def __init__(self, x0:np.array, y0:np.array, k:float, niter:int):
        """ Initialize a standard map object
        
        Args:
            x0 (numpy.array): np.array of size n. Initial points x coordinate
            y0 (numpy.array): np.array of size n. Initial points y coordinate
            k (float): parameter of the standard map
            niter (int): number of iterations
        """

        if( x0.size!=y0.size ):
            raise ValueError('x0 and y0 should have the same number of elements')

        self.k  = k
        self.npts = x0.size
        self.niter = niter
        self.x = np.zeros((self.npts,self.niter))
        self.y = np.zeros((self.npts,self.niter))
        self.x[0:self.npts,0] = x0
        self.y[0:self.npts,0] = y0
        

    def evaluate_map(self, nfp:int=1):
        """ Iterates on the map

        Args:
            nfp: Number of periods to be considered 
        """

        for ii in range(1, self.niter):
            self.y[:,ii] = np.mod(self.y[:,ii-1] - self.k/(2*np.pi)*np.sin(2*np.pi*self.x[:,ii-1]), nfp);
            self.x[:,ii] = np.mod(self.x[:,ii-1] + self.y[:,ii], nfp);


    def plot(self, ax=None, **kwargs):
        """ Plots the map

        Args:
            - ax (matplotlib.axes.Axes): axis on which the map should be plotted. If None, a new figure is created
            - kwards: any argument that can be passed to matplotlib.pyplot.scatter

        Return:
            ax (matplotlib.axes.Axes)
        """

        if ax is None: fig, ax = plt.subplots(figsize=(10,8))

        for ii in range(0,self.npts):
            ax.scatter(self.x[ii,:],self.y[ii,:],**kwargs)







