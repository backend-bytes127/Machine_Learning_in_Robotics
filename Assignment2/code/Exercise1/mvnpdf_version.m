function [output] = mvnpdf_version(data,mean,covariance)

output =  (1/sqrt((2*pi)^length(data)*det(covariance)))*exp(-0.5*(data - mean).'*(covariance\(data - mean)));

end